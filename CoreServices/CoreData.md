# Core Data
Core Data is a framework that you use to manage the model layer objects in your application

## Setup
[Defining an Entity Description](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/KeyConcepts.html#//apple_ref/doc/uid/TP40001075-CH30-SW1)
```objectivec
NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
NSManagedObjectModel managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];

NSError *error = nil;
NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];

if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
...
}

NSManagedObjectContext *managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator;
```



## Insert

## Query

## Update/Delete 
