//
//  AppDelegate.m
//  HW7
//
//  Created by Руслан on 18.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "Runner.h"
#import "Swimmer.h"
#import "Jumper.h"
#import "Kangaroo.h"
#import "Loafer.h"
#import "Jumpers.h"
#import "Runners.h"
#import "Swimmers.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    Runner* runner = [[Runner alloc] init];
    Jumper* jumper = [[Jumper alloc] init];
    Swimmer* swimmer = [[Swimmer alloc] init];
    Kangaroo* kangaroo = [[Kangaroo alloc] init];
    Loafer* loafer = [[Loafer alloc] init];
    
    runner.name = @"Ruslan";
    jumper.name = @"Eduard";
    swimmer.name = @"Akram";
    kangaroo.name = @"Sharik";
    loafer.name = @"Zahar";
    
    NSArray* superGuys = @[runner, jumper, swimmer, kangaroo, loafer];
    
    for (id guy in superGuys) {
        if ([guy respondsToSelector:@selector(run)]) {
            Runner* tempRunner = (Runner*)guy;
            NSLog(@"%@", [tempRunner run]);
            if ([guy respondsToSelector:@selector(laugh)]) {
                NSLog(@"%@", [tempRunner laugh]);
            }
        }
        if ([guy respondsToSelector:@selector(jump)]) {
            Jumper* tempJumper = (Jumper*)guy;
            NSLog(@"%@", [tempJumper jump]);
            if ([guy respondsToSelector:@selector(laugh)]) {
                NSLog(@"%@", [tempJumper laugh]);
            }
        } 
        if ([guy respondsToSelector:@selector(swim)]) {
            Swimmer* tempSwimmer = (Swimmer*)guy;
            NSLog(@"%@", [tempSwimmer swim]);
            if ([guy respondsToSelector:@selector(laugh)]) {
                NSLog(@"%@", [tempSwimmer laugh]);
            }
        }
        if ([guy isMemberOfClass:[Loafer class]]) {
            NSLog(@"IT IS A LOAFER!!!");
        }
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
