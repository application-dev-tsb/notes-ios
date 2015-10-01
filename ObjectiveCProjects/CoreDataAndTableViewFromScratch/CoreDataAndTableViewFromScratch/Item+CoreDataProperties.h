//
//  Item+CoreDataProperties.h
//  CoreDataAndTableViewFromScratch
//
//  Created by Lyndon Michael Bibera on 10/1/15.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Item.h"

NS_ASSUME_NONNULL_BEGIN

@interface Item (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSDate *dateAdded;
@property (nullable, nonatomic, retain) NSString *itemGroup;

@end

NS_ASSUME_NONNULL_END
