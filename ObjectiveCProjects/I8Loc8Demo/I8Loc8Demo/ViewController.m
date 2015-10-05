//
//  ViewController.m
//  I8Loc8Demo
//
//  Created by Lyndon Michael Bibera on 05/10/2015.
//  Copyright © 2015 Lyndon Michael Bibera. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)change:(UIButton *)sender
{
    NSString *myString = NSLocalizedString(@"Change", "The title of the button when it is changed");
    
    NSLog(@"Title: %@", myString);
    
    [sender setTitle:myString forState:UIControlStateNormal];
}

@end
