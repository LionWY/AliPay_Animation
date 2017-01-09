//
//  AppDelegate.m
//  AlipayTest
//
//  Created by FOODING on 16/4/22.
//  Copyright © 2016年 FOODING. All rights reserved.
//
/******
 -------------------------------------------------------------------------------
 要点：1，找一个特定的值来确定btn位置，这里面找的是btn的tag值，可以自定义
      2，先做基本功能，删除之后位置自动移动
      3，移动的时候，先做移动状态end时，位置确定，（两部分，往后移，往前移）在进行change状态
      4, 假设只能存在三行


 -------------------------------------------------------------------------------
 *****/

#import "AppDelegate.h"
#import "Config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    _addArray = [[NSMutableArray alloc] init];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can
    // occur for certain types of temporary interruptions (such as an incoming phone call
    // or SMS message) or when the user quits the application and it begins the transition
    // to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES
    // frame rates. Games should use this method to pause the game.

    NSArray *arr = [NSArray arrayWithArray:self.lastArray];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:KLASTARRAY];

    NSArray *arr2 = [NSArray arrayWithArray:self.currentArray];
    [[NSUserDefaults standardUserDefaults] setObject:arr2 forKey:KCURRENTARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and
    // store enough application state information to restore your application to its
    // current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of
    // applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here
    // you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was
    // inactive. If the application was previously in the background, optionally refresh
    // the user interface.

    NSArray *arr = [[NSUserDefaults standardUserDefaults] objectForKey:KCURRENTARRAY];

    self.currentArray = arr.mutableCopy;

    NSArray *arr2 = [[NSUserDefaults standardUserDefaults] objectForKey:KLASTARRAY];
    self.lastArray = arr2.mutableCopy;

    if (!self.currentArray) {
        self.currentArray =
            @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9" ].mutableCopy;
    }
    if (!self.lastArray) {
        self.lastArray =
            @[ @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19" ]
                .mutableCopy;
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See
    // also applicationDidEnterBackground:.

    NSArray *arr = [NSArray arrayWithArray:self.lastArray];
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:KLASTARRAY];

    NSArray *arr2 = [NSArray arrayWithArray:self.currentArray];
    [[NSUserDefaults standardUserDefaults] setObject:arr2 forKey:KCURRENTARRAY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
