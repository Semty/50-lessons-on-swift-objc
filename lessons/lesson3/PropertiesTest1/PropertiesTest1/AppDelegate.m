//
//  AppDelegate.m
//  PropertiesTest1
//
//  Created by Руслан on 14.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "Boxer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    Boxer* boxer = [[Boxer alloc] init];
    
    boxer.name = @"Vasiliy";
    boxer.surname = @"Kotov";
    /*
    boxer.age = 25;
    boxer.height = 184.8f;
    boxer.weight = 80.2f;
    */
    /*
    [boxer setName:@"Vasiliy"];
    [boxer setAge:25];
    [boxer setHeight:184.4f];
    [boxer setWeight:80.2f];
    */
    /*
    NSLog(@"Name: %@", boxer.name);
    NSLog(@"Age: %d", boxer.age);
    NSLog(@"Height: %f", boxer.height);
    NSLog(@"Weight: %f", boxer.weight);
    */
    /*
    NSLog(@"Name: %@", [boxer name]);
    NSLog(@"Name: %@", boxer.name);
    NSLog(@"Age: %d", [boxer age]);
    NSLog(@"Height: %f", [boxer height]);
    NSLog(@"Weight: %f", [boxer weight]);
    NSLog(@"How old are you?");
    NSLog(@"I am %d", [boxer howOldAreYou]);
    */
    NSLog(@"My fullname is %@", [boxer name:boxer.name surname:boxer.surname]);
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
