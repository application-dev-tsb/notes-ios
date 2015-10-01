//
//  AppDelegate.h
//  CoreDataAndTableViewFromScratch
//
//  Created by Lyndon Michael Bibera on 10/1/15.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

