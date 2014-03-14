//
//  AppDelegate.m
//  Gripthumb
//
//  Created by Sean Doyle on 3/12/14.
//  Copyright (c) 2014 Gripthumb. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard"
                                                         bundle: nil];
    UIViewController* rootController = [storyboard instantiateViewControllerWithIdentifier: @"root"];
    
    UINavigationController* navigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // Configure Window
    [self.window setRootViewController:navigationController];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end