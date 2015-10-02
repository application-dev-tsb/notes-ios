//
//  ItemTableViewController.h
//  CoreDataAndTableViewFromScratch
//
//  Created by Lyndon Michael Bibera on 10/1/15.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "AppDelegate.h"
#import "Item.h"
#import "Item+CoreDataProperties.h"
#import "NSNumber+Increment.h"

@interface ItemTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@end
