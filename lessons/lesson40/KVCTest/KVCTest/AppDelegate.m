//
//  AppDelegate.m
//  KVCTest
//
//  Created by Руслан on 04.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"
#import "RTGroup.h"

@interface AppDelegate ()

@property (strong, nonatomic) RTStudent *student;
@property (strong, nonatomic) NSArray *groups;

@end

NSString *kName     = @"name";
NSString *kAge      = @"age";
NSString *kStudents = @"students";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    /*
    RTStudent *student = [[RTStudent alloc] init];
    
    self.student = student;
    [self.student addObserver:self
                   forKeyPath:kName
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    student.name = @"Ruslan";
    student.age = 19;
    
    NSLog(@"%@", student);
    
    [student setValue:@"Roger"  forKey:kName];
    [student setValue:@25       forKey:kAge];
    
    NSLog(@"name = %@, age = %@", [student valueForKey:kName], [student valueForKey:kAge]);
    
    [student changeName];
     */
    
    RTStudent *student1 = [[RTStudent alloc] init];
    student1.name = @"Ruslan";
    student1.age = 19;
    
    RTStudent *student2 = [[RTStudent alloc] init];
    student2.name = @"Roger";
    student2.age = 25;

    RTStudent *student3 = [[RTStudent alloc] init];
    student3.name = @"Jack";
    student3.age = 22;
    
    RTStudent *student4 = [[RTStudent alloc] init];
    student4.name = @"Vova";
    student4.age = 28;

    RTGroup *group1 = [[RTGroup alloc] init];
    group1.students = @[ student1, student2, student3, student4 ];
    
    /*
    NSLog(@"group1.students = %@", group1.students);
     
    NSMutableArray *array = [group1 mutableArrayValueForKey:kStudents];
    [array removeLastObject];
    
    [[group1 mutableArrayValueForKey:kStudents] removeLastObject];
    
    NSLog(@"array = %@", group1.students);
    */
    /*
    self.student = student1;
    NSLog(@"name = %@", [self valueForKeyPath:@"student.name"]);
    
    NSString *name = @"Ruslan123";
    NSError *error = nil;
    
    if (![self.student validateValue:&name
                              forKey:kName
                               error:&error]) {
        
        NSLog(@"%@", [error localizedDescription]);
    }
    */
    
    RTStudent *student5 = [[RTStudent alloc] init];
    student5.name = @"Vasya";
    student5.age = 18;
    
    RTStudent *student6 = [[RTStudent alloc] init];
    student6.name = @"Kolya";
    student6.age = 24;
    
    RTGroup *group2 = [[RTGroup alloc] init];
    group2.students = @[ student5, student6 ];
    
    self.groups = @[ group1, group2 ];
    
    NSLog(@"groups count %@", [self valueForKeyPath:@"groups.@count"]);
    
    NSArray *allStudents = [self valueForKeyPath:@"groups.@distinctUnionOfArrays.students"];
    
    NSLog(@"allStudents = %@", allStudents);
    
    NSNumber *minAge = [allStudents valueForKeyPath:@"@min.age"];
    NSNumber *maxAge = [allStudents valueForKeyPath:@"@max.age"];
    NSNumber *avgAge = [allStudents valueForKeyPath:@"@avg.age"];
    NSNumber *sumAge = [allStudents valueForKeyPath:@"@sum.age"];
    
    NSLog(@"minAge = %@, maxAge = %@, avgAge = %@, sumAge = %@", minAge, maxAge,
          [NSString stringWithFormat:@"%1.1f", [avgAge floatValue]], sumAge);
    
    NSArray *allNames = [allStudents valueForKeyPath:@"@distinctUnionOfObjects.name"];
    
    NSLog(@"%@", allNames);
    
    return YES;
}

#pragma mark - dealloc

- (void) dealloc {
    //[self.student removeObserver:self forKeyPath:kName];
}

#pragma mark - Observing

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                        context:(void *)context {
    
    NSLog(@"\nobserveValueForKeyPath: %@\nobject: %@\nchange: %@", keyPath, object, change);
    
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
