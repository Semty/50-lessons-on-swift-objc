//
//  AppDelegate.m
//  NotificationsTest
//
//  Created by Руслан on 23.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "Government.h"
#import "Doctor.h"

@interface AppDelegate ()

@property (strong, nonatomic) Government *government;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.government = [[Government alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(governmentNotification:)
                                                 name:GovernmentTaxLevelDidChangeNotification
                                               object:nil];
    
    Doctor *doctor1 = [[Doctor alloc] init];
    Doctor *doctor2 = [[Doctor alloc] init];
    Doctor *doctor3 = [[Doctor alloc] init];
    Doctor *doctor4 = [[Doctor alloc] init];
    Doctor *doctor5 = [[Doctor alloc] init];
    
    doctor1.salary = doctor2.salary = doctor3.salary = doctor4.salary = doctor5.salary = self.government.salary;
    
    self.government.taxLevel = 5.5f;
    self.government.salary = 1100.f;
    self.government.averagePrice = 15.f;
    self.government.pension = 550.f;
    NSLog(@"\n\n");
    self.government.salary = 1050.f;
    NSLog(@"\n\n");
    self.government.salary = 1150.f;
    NSLog(@"\n\n");
    self.government.salary = 900.f;
    NSLog(@"\n\n");
    
    return YES;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) governmentNotification:(NSNotification *)notification {
    //NSLog(@"\n\n\ngovernmentNotification userInfo = %@\n\n", notification.userInfo);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
