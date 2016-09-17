//
//  AppDelegate.m
//  HW6
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTHuman.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                      *** 1 ***
    RTHuman* ruslan = [[RTHuman alloc] init];
    
    ruslan.name = @"Ruslan";
    ruslan.gender = Male;
    ruslan.direction = Ahead;
    
    NSLog(@"%@", [ruslan printSelf:ruslan.name :ruslan.gender :ruslan.direction]);
    
    //                                      *** 2 && 3 ***
    CGRect table = CGRectMake(0, 0, 10, 10);
    CGRect target = CGRectMake(3, 3, 4, 4);
    
    CGPoint point1 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point2 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point3 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point4 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point5 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point6 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point7 = CGPointMake(arc4random()%10, arc4random()%10);
    CGPoint point8 = CGPointMake(arc4random()%10, arc4random()%10);
    
    NSArray* points = @[[NSValue valueWithCGPoint:point1],
                        [NSValue valueWithCGPoint:point2],
                        [NSValue valueWithCGPoint:point3],
                        [NSValue valueWithCGPoint:point4],
                        [NSValue valueWithCGPoint:point5],
                        [NSValue valueWithCGPoint:point6],
                        [NSValue valueWithCGPoint:point7],
                        [NSValue valueWithCGPoint:point8]];
    
    NSInteger count = 0;
    
    for (NSValue* value in points) {
        
        CGPoint point = [value CGPointValue];
        count += 1;
        
        if (CGRectContainsPoint(table, point) && CGRectContainsPoint(target, point)) {
            
            NSLog(@"point%ld %@ hit in the target! (target has origin %@, height/width %@)",
                  count, NSStringFromCGPoint(point), NSStringFromCGPoint(target.origin),
                  NSStringFromCGSize(target.size));
            
        } else if (CGRectContainsPoint(table, point)) {
            NSLog(@"point%ld %@ is missed", count, NSStringFromCGPoint(point));
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
