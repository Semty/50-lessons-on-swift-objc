//
//  AppDelegate.m
//  TypesTest
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
    BOOL boolVar1 = YES;
    
    NSInteger intVar1 = 10;
    
    NSUInteger uIntVar1 = 0;
    
    CGFloat floatVar1 = 5.5f;
    
    double doubleVar1 = 10.25;
    
    NSNumber* boolVar = [[NSNumber alloc] initWithBool:boolVar1];
    NSNumber* intVar = [[NSNumber alloc] initWithInteger:intVar1];
    NSNumber* uIntVar = [[NSNumber alloc] initWithUnsignedInteger:uIntVar1];
    NSNumber* floatVar = [[NSNumber alloc] initWithFloat:floatVar1];
    NSNumber* doubleVar = [[NSNumber alloc] initWithDouble:doubleVar1];
    
    NSArray* numbers = @[boolVar, intVar, uIntVar, floatVar, doubleVar];
    
    for (NSNumber* number in numbers) {
        NSLog(@"numbers: %@", number);
    }
    
    NSLog(@"boolVar = %d, intVar = %ld, uIntVar = %lu, floatVar = %f, doubleVar = %f",
          [numbers[0] boolValue],
          [numbers[1] longValue],
          [numbers[2] unsignedLongValue],
          [numbers[3] floatValue],
          [numbers[4] doubleValue]);*/
    
    /*
    NSLog(@"boolVar = %ld, intVar = %ld, uIntVar = %lu, floatVar = %lu, doubleVar = %lu",
          sizeof(boolVar1), sizeof(intVar1), sizeof(uIntVar1), sizeof(floatVar1), sizeof(doubleVar1));
    */
    /*
    RTStudent* studentA = [[RTStudent alloc] init];
    studentA.name = @"Best student";
    
    RTStudent* studentB = studentA;
    
    NSLog(@"StudentA name is *%@*", studentA.name);
    
    studentB.name = @"Bad student";
    NSLog(@"StudentA name is *%@*", studentA.name); // reference type
    */
    /*
    NSInteger a = 10;
    NSLog(@"a = %ld", a);
    
    NSInteger b = a;
    b = 5;
    NSLog(@"a = %ld", a); // value type
    
    NSInteger* c = &a;
    *c = 8;
    NSLog(@"a = %ld", a); // reference type
    
    [self test:&a]; // reference type
    
    NSLog(@"a = %ld", a);
    */
    /*
    RTStudent* ruslan = [[RTStudent alloc] init];
    
    ruslan.name = @"Ruslan";
    ruslan.gender = Male;
    
    NSLog(@"Gender is %u", ruslan.gender);*/
    /*
    CGPoint point;
    // point.x = 5.5f;
    // point.y = 8.2f;
    point = CGPointMake(5.5f, 8.2f);
    
    CGSize size;
    // size.height = 5;
    // size.width = 2;
    size = CGSizeMake(5, 2);
    
    CGRect rect;
    // rect.origin = point;
    // rect.size = size;
    rect = CGRectMake(point.x, point.y, size.width, size.height);
    */
    
    CGPoint point1 = CGPointMake(0, 1);
    CGPoint point2 = CGPointMake(3, 2);
    CGPoint point3 = CGPointMake(6, 4);
    
    NSValue* valuePoint1 = [NSValue valueWithCGPoint:point1];
    NSValue* valuePoint2 = [NSValue valueWithCGPoint:point2];
    NSValue* valuePoint3 = [NSValue valueWithCGPoint:point3];
    
    NSArray* points = @[valuePoint1, valuePoint2, valuePoint3];
    
    for (NSValue* value in points) {
        CGPoint point = [value CGPointValue];
        
        NSLog(@"%@", NSStringFromCGPoint(point));
    }
    
    return YES;
}

- (void) test:(NSInteger*)test {
    *test -= 1;
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
