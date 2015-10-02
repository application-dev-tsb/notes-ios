//
//  NSNumber+Increment.m
//  CoreDataAndTableViewFromScratch
//
//  Created by Lyndon Michael Bibera on 10/2/15.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//

#import "NSNumber+Increment.h"

@implementation NSNumber (Increment)

- (NSNumber*)increment
{
    return [NSNumber numberWithInt:[self intValue] + 1];
}

@end
