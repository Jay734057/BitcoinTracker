//
//  AppDelegate.m
//  BitcoinTracker
//
//  Created by Jianyu ZHU on 2/11/17.
//  Copyright © 2017 Unimelb. All rights reserved.
//

#import "AppDelegate.h"
#import "BitcoinTrackerViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [[BitcoinTrackerViewController alloc]init];
    
    return YES;
}


@end
