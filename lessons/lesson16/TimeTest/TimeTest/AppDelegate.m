//
//  AppDelegate.m
//  TimeTest
//
//  Created by Руслан on 05.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTObject.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /*
    NSDate *date = [NSDate date];
    
    NSLog(@"\n\n\n%@\n\n\n",  date);
    NSLog(@"\n\n\n%@\n\n\n", [date dateByAddingTimeInterval:5000]);
    NSLog(@"\n\n\n%@\n\n\n", [date dateByAddingTimeInterval:-5000]);
    
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceReferenceDate:5];
    
    NSLog(@"\n\n\n%@\n\n\n",  date2);
    */
    /*
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSLog(@"\n\n\n%@\n\n\n", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLog(@"\n\n\n%@\n\n\n", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    NSLog(@"\n\n\n%@\n\n\n", [dateFormatter stringFromDate:date]);
    
    [dateFormatter setDateStyle:NSDateFormatterFullStyle];
    NSLog(@"\n\n\n%@\n\n\n", [dateFormatter stringFromDate:date]);
    
    //[dateFormatter setDateFormat:@"yyyy M MM MMM MMMM MMMMM"];
    [dateFormatter setDateFormat:@"dd.MM.yy, EEE - HH:mm"];
    NSLog(@"\n\n\n%@\n\n\n", [dateFormatter stringFromDate:date]);
    
    NSDate *date3 = [dateFormatter dateFromString:@"12.11.04, Mon - 22:13"];
    NSLog(@"\n\n\n%@\n\n\n", date3);
    */
    /*
    NSDate *date1 = [NSDate date];
    NSDate *date2 = [NSDate dateWithTimeIntervalSinceNow:-1000000];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    //NSDateComponents *components =
    //[calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
                         //NSCalendarUnitHour | NSCalendarUnitMinute| NSCalendarUnitSecond
                //fromDate:date];
    
    //NSLog(@"\n\n\n%@\n\n\n", components);
    
    
    NSDateComponents *components = [calendar components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute
                                               fromDate:date2
                                                 toDate:date1
                                                options:0];
    
    NSLog(@"\n\n\n%@\n\n%@\n\n\n%@\n\n\n", date2, date1, components);
    */
    
    RTObject *object = [[RTObject alloc] init];
    
    
    
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
