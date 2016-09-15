//
//  AppDelegate.m
//  Lesson5
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTHuman.h"
#import "RTCyclist.h"
#import "RTRunner.h"
#import "RTSwimmer.h"
#import "RTBoxer.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Level: learner
    RTHuman* human = [[RTHuman alloc] init];
    RTCyclist* cyclist = [[RTCyclist alloc] init];
    RTRunner* runner = [[RTRunner alloc] init];
    RTSwimmer* swimmer = [[RTSwimmer alloc] init];
    
    human.name = @"Zahar";
    human.height = 174.5f;
    human.weight = 66.5f;
    human.gender = @"Male";
    
    cyclist.name = @"Ruslan";
    cyclist.height = 182.0f;
    cyclist.weight = 61.5f;
    cyclist.gender = @"Male";
    
    runner.name = @"Eduard";
    runner.height = 178.3f;
    runner.weight = 66.2f;
    runner.gender = @"Male";
    
    swimmer.name = @"Galya";
    swimmer.height = 164.6f;
    swimmer.weight = 52.1f;
    swimmer.gender = @"Female";
    /*
    NSArray* people = @[human, cyclist, runner, swimmer];
    
    for (RTHuman* human in people) {
        NSLog(@"Name: %@", human.name);
        NSLog(@"Height: %f", human.height);
        NSLog(@"Weight: %f", human.weight);
        NSLog(@"Gender: %@", human.gender);
        [human movement];
        NSLog(@"\n");
    }
    */
    
    // Level: student
    RTBoxer* boxer = [[RTBoxer alloc] init];
    
    boxer.name = @"Akram";
    boxer.height = 174.5f;
    boxer.weight = 64.7f;
    boxer.gender = @"Male";
    boxer.skinColor = @"White";
    boxer.nationality = @"Tajik";
    
    NSArray* people = @[human, cyclist, runner, swimmer, boxer];
    
    for (RTHuman* human in people.reverseObjectEnumerator) {
        NSLog(@"Name: %@", human.name);
        NSLog(@"Height: %f", human.height);
        NSLog(@"Weight: %f", human.weight);
        NSLog(@"Gender: %@", human.gender);
        if ([human isMemberOfClass:[RTBoxer class]]) {
            NSLog(@"Skin color: %@", ((RTBoxer*)human).skinColor);
            NSLog(@"Nationality: %@", ((RTBoxer*)human).nationality);
        }
        [human movement];
        NSLog(@"\n");
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
