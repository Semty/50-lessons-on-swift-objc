//
//  AppDelegate.m
//  ArraysTest
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTObject.h"
#import "RTChild.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // NSArray* array = [[NSArray alloc] initWithObjects:@"String 1", @"String 2", @"String 3", nil];
    // NSArray* array = [NSArray arrayWithObjects:@"String 1", @"String 2", @"String 3", nil];
    // NSArray* array = @[@"String 1", @"String 2", @"String 3"];
    /*
    for (int i = (int)[array count] - 1; i >= 0; i--) {
        NSLog(@"%@; i = %d", array[i], i);
    }
    
    for (NSString* string in array.reverseObjectEnumerator) {
        NSLog(@"%@ with index of %lu",
              string, [array indexOfObject:string]);
    }
     */
    
    RTObject* obj1 = [[RTObject alloc] init];
    RTObject* obj2 = [[RTObject alloc] init];
    RTChild* obj3 = [[RTChild alloc] init];
    obj1.name = @"Ruslan";
    obj2.name = @"Eduard";
    [obj3 setName:@"Akram"];
    [obj3 setLastname:@"Makhmudov"];
    
    NSArray* objects = @[obj1, obj2, obj3];
    
    for (RTObject* object in objects) {
        NSLog(@"name = %@", object.name);
        if ([object isMemberOfClass:[RTChild class]]) {
            NSLog(@"lastname: %@", ((RTChild*)object).lastname);
        }
        [object action];
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
