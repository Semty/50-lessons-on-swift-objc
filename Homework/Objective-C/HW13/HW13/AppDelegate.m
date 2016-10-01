//
//  AppDelegate.m
//  HW13
//
//  Created by Руслан on 01.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                                  *** LEARNER && STUDENT ***
    RTStudent *student1 = [[RTStudent alloc] initWithName:@"Ruslan(1)"];
    RTStudent *student2 = [[RTStudent alloc] initWithName:@"Dasha(2)"];
    RTStudent *student3 = [[RTStudent alloc] initWithName:@"Akram(3)"];
    RTStudent *student4 = [[RTStudent alloc] initWithName:@"Eduard(4)"];
    RTStudent *student5 = [[RTStudent alloc] initWithName:@"Zahar(5)"];
    
    NSArray *students = @[ student1, student2, student3, student4, student5 ];
    
    NSInteger maxNumber = 10000001; // = 0...10000000
    NSInteger randomNumber = arc4random() % maxNumber;
    
    dispatch_queue_t studentQueue = dispatch_queue_create("com.rstimchenko.hw13.studentqueue", DISPATCH_QUEUE_CONCURRENT);
    
    void (^resultBlock)(NSString *, double) = ^(NSString *name, double time) {
        NSLog(@"%@ ended in %f sec!", name, time);
    };
    
    NSLog(@"\n\n\n");
    for (RTStudent *student in students) {
        [student guessTheAnswer:randomNumber withMaxNumber:maxNumber andQueue:studentQueue withResultBlock:resultBlock];
    }
    NSLog(@"\n\n\n");
    
    return YES;
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
