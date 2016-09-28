//
//  AppDelegate.m
//  BlocksTest
//
//  Created by Руслан on 28.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTObject.h"

typedef  void (^OurTestBlock)(void);
typedef  NSString *(^OurTestBlock2)(NSInteger);

@interface AppDelegate ()

@property (copy, nonatomic) OurTestBlock testBlock;
@property (strong, nonatomic) NSString *name;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //[self testMethod];
    /*
    void (^testBlock)(void);
    
    testBlock = ^{
        NSLog(@"\n\n\ntest block!\n\n\n");
    };
    
    testBlock();
    
    //[self testMethodWithParameters:@"hi! i am" value:19];
    
    void (^testBlockWithParameters)(NSString *, NSInteger) = ^(NSString *string, NSInteger integer) {
        NSLog(@"\n\n\ntestBlockWithParameters %@ %ld!\n\n\n", string, integer);
    };
    
    testBlockWithParameters(@"hi! i am", 19);
    
    //NSLog(@"%@", [self testMethodWithReturnValueAndParameters:@"kekeke" value:228]);
    
    NSString * (^testBlockWithReturnValueAndParameters)(NSString *, NSInteger) = ^(NSString *string, NSInteger integer) {
        return [NSString stringWithFormat:@"\n\n\ntestBlockWithReturnValueAndParameters %@ %ld!\n\n\n", string, integer];
    };
    
    NSLog(@"%@", testBlockWithReturnValueAndParameters(@"kekeke", 228));*/
    /*
    __block NSString *string = @"How is it possible?";
    
    void (^testBlock2)(void);
    
    __block NSInteger i = 0;
    
    testBlock2 = ^{
        NSLog(@"\n\n\ntest block!\n\n\n");
        i += 1;
        string = [NSString stringWithFormat:@"How is it possible? - %ld", i];
        NSLog(@"\n\n\n%@\n\n\n", string);
    };
    
    testBlock2();
    testBlock2();
    testBlock2();
    testBlock2();
    testBlock2();
     
    NSArray *array = nil;
     
    NSComparisonResult (^sorted)(id, id) = ^(id obj1, id obj2) {
    return NSOrderedDescending;
    };
     
    array = [array sortedArrayUsingComparator:sorted];
     
    void (^someBlock)(void) = ^{
    NSLog(@"\n\nBLOCK!!!");
    };
     
    [self testBlocksMethod:someBlock];
    */
    /*
    [self testBlocksMethod:^{
        NSLog(@"\n\nBLOCK!!!");
    }];
    
    OurTestBlock block = ^{
        NSLog(@"My new block's system!");
    };
    
    OurTestBlock2 block2 = ^(NSInteger intValue) {
        return [NSString stringWithFormat:@"%ld - string!", intValue];
    };
    
    [self testBlocksMethod:block];
    
    NSLog(@"%@", block2(12345));*/
    /*
    
    __weak RTObject *weakObj = obj;
    
    self.testBlock = ^{
        NSLog(@"Name of our object is %@", weakObj.name);
    };
    
    self.testBlock();*/
    
    self.name = @"Eduard";
    
    RTObject *obj = [[RTObject alloc] init];
    obj.name = @"Ruslan";
    
    /*[obj testMethod:^{
        NSLog(@"%@", self.name);
    }];*/
    
    return YES;
}

- (void) testMethod {
    NSLog(@"\n\n\ntest method!\n\n\n");
}

- (void) testMethodWithParameters:(NSString *)string value:(NSInteger)integer {
    NSLog(@"\n\n\ntestMethodWithParameters %@ %ld!\n\n\n", string, integer);
}

- (void) testBlocksMethod:(void (^)(void))testBlock {
    
    NSLog(@"\n\ntestBlocksMethod");
    
    testBlock();
}

- (NSString *) testMethodWithReturnValueAndParameters:(NSString *)string value:(NSInteger)integer {
    return [NSString stringWithFormat:@"\n\n\ntestMethodWithReturnValueAndParameters %@ %ld!\n\n\n", string, integer];
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
