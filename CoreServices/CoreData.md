# Core Data
Core Data is a framework that you use to manage the model layer objects in your application

## Setup
[Defining an Entity Description](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CoreData/KeyConcepts.html#//apple_ref/doc/uid/TP40001075-CH30-SW1)
```objectivec
NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CoreDataDemo" withExtension:@"momd"];
NSManagedObjectModel managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
NSPersistentStoreCoordinator persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];


```



## Insert

## Query

## Update/Delete 
