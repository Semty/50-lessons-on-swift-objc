//
//  AppDelegate.m
//  SelectorsTest
//
//  Created by Руслан on 25.09.16.
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
    SEL selector1 = @selector(testMethod);
    RTObject *someObject = [[RTObject alloc] init];
    SEL selector2 = @selector(testMethod:);
    SEL selector3 = @selector(testMethod: parameter2:);
    
    [self performSelector:selector1];
    [someObject performSelector:selector1];
    
    NSLog(@"%@", [someObject performSelector:@selector(superSecretText)]);
    
    [self performSelector:selector2 withObject:@"nya-nya"];
    [self performSelector:selector3 withObject:@"nya-nya" withObject:@"tra-lya-lya"];
    [self performSelector:selector1 withObject:nil afterDelay:5.5f];
    
    [self performSelector:@selector(testMethodParameter1:parameter2:parameter3:) withObject:@5];
    */
    
    //NSString *string = [self testMethodParameter1:5 parameter2:5.5 parameter3:5.55555555];
    //NSLog(@"%@", string);
    
    SEL selector = @selector(testMethodParameter1:parameter2:parameter3:);
    
    NSMethodSignature *methodSignature = [AppDelegate instanceMethodSignatureForSelector:selector];
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    
    [invocation setTarget:self];
    [invocation setSelector:selector];
    
    NSInteger intValue = 5;
    Float64 floatValue = 5.5;
    double doubleValue = 5.5555555;
    
    [invocation setArgument:&intValue atIndex:2];
    [invocation setArgument:&floatValue atIndex:3];
    [invocation setArgument:&doubleValue atIndex:4];
    
    [invocation invoke];
    
    NSString *string = nil;
    
    [invocation getReturnValue:&string];
    
    NSLog(@"%@", string);
    
    return YES;
}

- (void) testMethod {
    NSLog(@"\n\n\ntestMethod\n\n\n");
}

- (void) testMethod:(NSString *)string {
    NSLog(@"\n\n\ntestMethod: %@\n\n\n", string);
}

- (void) testMethod:(NSString *)string1 parameter2:(NSString *)string2 {
    NSLog(@"\n\n\ntestMethod parameter2: %@, %@\n\n\n", string1, string2);
}

- (NSString*) testMethodParameter1:(NSInteger)intValue parameter2:(Float64)floatValue parameter3:(double)doubleValue {
    return [NSString stringWithFormat:@"\n\n\ntestMethodParameter1: %ld, par2: %f, par3: %f\n\n\n", intValue, floatValue, doubleValue] ;
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
