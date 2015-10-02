# Core Data
Core Data is a framework that you use to manage the model layer objects in your application

## Setup
[Defining an Entity Description](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/KeyConcepts.html#//apple_ref/doc/uid/TP40001075-CH30-SW1)
```objectivec
//creating a ManagedObjectContext
NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

NSURL *applicationDocumentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
NSError *error = nil;
NSURL *storeURL = [applicationDocumentsDirectory URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];

if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
...
}

NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
```
```objectivec
//fetched results controller: coordinating with core data with a table view controller
- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entityDescription;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dateCreated" ascending:YES];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"groupName" cacheName:@"MainCache"];
    _fetchedResultsController = fetchedResultsController;
    
    if (![fetchedResultsController performFetch:nil]) {
        //TODO: handle error
        abort();
    }
    
    _fetchedResultsController.delegate = self; //VERY IMPORTANT!!!
    return _fetchedResultsController;
}
```



## Insert
```objectivec
//to insert a new item
- (void)addItem
{
    Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    item.name = @"New Item";
    item.dateAdded = [NSDate date];
    item.itemGroup = @"Group 01";
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error Saving");
        abort();
    }
}

//to animate insertion: using NSFetchedResultsController
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
```

## Query
```objectivec
NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.fetchedResultsController.fetchRequest.entityName];
    
NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemGroup = %@", groupName];
fetchRequest.predicate = predicate;
    
NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"orderInGroup" ascending:NO];
fetchRequest.sortDescriptors = @[sort];
    
NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
```

## Update

## Delete 
<img src="/ObjectiveCProjects/CoreDataAndTableViewFromScratch/EditMode.png" width="200">
```objectivec
//check if row is editable:
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; //YES or NO
}
```

<img src="/ObjectiveCProjects/CoreDataAndTableViewFromScratch/EditSwipe.png" width="200">
```objectivec
//override this to enable manual delete by swiping
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //performs the actual delete in CoreData
        NSManagedObjectContext *context = self.managedObjectContext;
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        NSError *error = nil;
        if (![context save:&error]) {
            //TODO: handle delete error
        }
    }
}
```
```objectivec
//animates the tableview during delete
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        ...
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        ...
    }
}
```

**Sources:**
* [Code: Demo Project](/ObjectiveCProjects/CoreDataAndTableViewFromScratch)
* [Apple Developer: Core Data Programming Guide](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/index.html#//apple_ref/doc/uid/TP40001075-CH2-SW1)
* [Tutsplus: Core Data and Batch Update](http://code.tutsplus.com/tutorials/ios-8-core-data-and-batch-updates--cms-22164)
