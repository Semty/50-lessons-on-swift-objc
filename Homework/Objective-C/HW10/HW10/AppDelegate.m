//
//  AppDelegate.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTGovernment.h"
#import "RTDoctor.h"
#import "RTBusinessman.h"
#import "RTPensioner.h"
#import "RTFakeAppDelegate.h"

@interface AppDelegate ()

@property (strong, nonatomic) RTGovernment *government;
@property (strong, nonatomic) RTDoctor *doctor;
@property (strong, nonatomic) RTPensioner *pensioner;
@property (strong, nonatomic) RTBusinessman *businessman;
@property (strong, nonatomic) RTFakeAppDelegate *fakeAppDelegate;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                                  *** LEARNER ***
    
    self.government = [[RTGovernment alloc] init];
    
    self.doctor = [[RTDoctor alloc] init];
    self.doctor.name = @"Ruslan";
    
    self.pensioner = [[RTPensioner alloc] init];
    self.pensioner.name = @"Eduard";
    
    self.businessman = [[RTBusinessman alloc] init];
    self.businessman.name = @"Akram";
    
    self.government.salary = 350.f;
    self.government.pension = 120.f;
    self.government.taxLevel = 18.5f;
    self.government.averagePrice = 8.f;
    //                                                  *** STUDENT (UMNICHKA) && MASTER ***
    self.government.averagePrice = 9.2f;
    self.government.averagePrice = 17.6f;
    self.government.averagePrice = 7.8f;
    //                                                  *** SUPERMAN ***
    NSLog(@"\n\n\n\n\n\n\n\n\n");
    self.fakeAppDelegate = [[RTFakeAppDelegate alloc] init];
    
    NSLog(@"REAL appDelegate DidFinishLaunchingNotification\n\n");
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    NSLog(@"REAL appDelegate WillResignActiveNotification\n\n");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"REAL appDelegate DidEnterBackgroundNotification\n\n");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    NSLog(@"REAL appDelegate WillEnterForegroundNotification\n\n");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"REAL appDelegate DidBecomeActiveNotification\n\n");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSLog(@"REAL appDelegate WillTerminateNotification\n\n");
}


@end
