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
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [self.window setRootViewController:rootController];
    
    return YES;
}

@end