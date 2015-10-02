//
//  ItemTableViewController.m
//  CoreDataAndTableViewFromScratch
//
//  Created by Lyndon Michael Bibera on 10/1/15.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//

#import "ItemTableViewController.h"

@interface ItemTableViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

@implementation ItemTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem)];
    //self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *randomItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(appendRandomThings)];
    self.navigationItem.rightBarButtonItems = @[addButton, randomItem];
}

- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    _managedObjectContext = appDelegate.managedObjectContext;
    
    return _managedObjectContext;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entityDescription;
    
    NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"orderInGroup" ascending:YES];
    NSSortDescriptor *sortGroup = [NSSortDescriptor sortDescriptorWithKey:@"itemGroup" ascending:YES];
    fetchRequest.sortDescriptors = @[sortGroup, sortOrder];
    
    NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"itemGroup" cacheName:@"MainCache"];
    _fetchedResultsController = fetchedResultsController;
    
    if (![fetchedResultsController performFetch:nil]) {
        //TODO: handle error
        abort();
    }
    
    _fetchedResultsController.delegate = self;
    return _fetchedResultsController;
}

//silly method adds letters at the end of random notes
- (void)appendRandomThings
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:self.fetchedResultsController.fetchRequest.entityName];
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"dateAdded" ascending:YES];
    fetchRequest.sortDescriptors = @[sort];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (!results) {
        return;
    }
    
    for (Item *item in results) {
        item.name = [NSString stringWithFormat:@"%@xxx", item.name];
    }
    
    [self.managedObjectContext save:nil];
}

- (void)addItem
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"New" message:@"Create a new TODO item" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Group...";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Task...";
    }];
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:self.managedObjectContext];
        item.itemGroup = alertController.textFields[0].text;
        item.name = alertController.textFields[1].text;
        item.dateAdded = [NSDate date];
        item.orderInGroup = [[self countItemsInGroup:item.itemGroup] increment];
        
        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error Saving");
            abort();
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alertController addAction:defaultAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSNumber*)countItemsInGroup:(NSString *)groupName
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:self.fetchedResultsController.fetchRequest.entityName];
    fetchRequest.fetchLimit = 1;
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemGroup = %@", groupName];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"orderInGroup" ascending:NO];
    fetchRequest.sortDescriptors = @[sort];
    
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    if ([results count] > 0) {
        Item *lastItem = [results firstObject];
        return lastItem.orderInGroup;
    }
    
    return @1;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    Item *item = (Item*)[self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@.) %@", item.orderInGroup, item.name];
}

//not really a batch update
- (void)batchUpdateOrderForItemGroup:(NSString *)itemGroup startingWithCount:(NSNumber *)countInGroup
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:self.fetchedResultsController.fetchRequest.entityName];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemGroup = %@ AND orderInGroup > %@", itemGroup, countInGroup];
    fetchRequest.predicate = predicate;
    
    NSSortDescriptor *sortOrderInGroup = [NSSortDescriptor sortDescriptorWithKey:@"orderInGroup" ascending:YES];
    fetchRequest.sortDescriptors = @[sortOrderInGroup];
    
    NSError *error = nil;
    NSArray *results = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (!results) {
        return;
    }
    
    NSNumber *currentCount = [countInGroup copy];
    for (Item *item in results) {
        item.orderInGroup = currentCount;
        currentCount = [currentCount increment];
        NSLog(@"updated:%@", item);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //get the first item of the section
    Item *item = [self.fetchedResultsController objectAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    return item.itemGroup;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = self.managedObjectContext;
        
        Item *toDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:toDelete];
        
        //update the orderInGroup property of the items after the deleted item
        [self batchUpdateOrderForItemGroup:toDelete.itemGroup startingWithCount:toDelete.orderInGroup];
        
        NSError *error = nil;
        if (![context save:&error]) {
            //TODO: handle delete error
        }
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
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

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationRight];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[self.tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

@end
