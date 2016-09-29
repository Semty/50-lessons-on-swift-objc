//
//  AppDelegate.m
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"
#import "RTStudentSuperman.h"

typedef  void (^VoidBlock)(void);
typedef  NSString *(^NSStringBlock)(NSString *);
typedef  void (^Doctor)(RTPatient *);

@interface AppDelegate ()

@property (strong, nonatomic) NSArray *patients;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                                  *** LEARNER ***
    NSLog(@"\n\n\nLEVEL: LEARNER\n\n");
    VoidBlock block1 = ^{
        NSLog(@"\n\n\nInput: void, output: void, number: block1\n\n");
    };
    
    NSString *string1 = @"string1";
    NSStringBlock block2 = ^(NSString *someString) {
        return [NSString stringWithFormat:@"\n\n\nInput: %@, output: %@, number: block2\n\n", someString, someString];
    };
    
    [self blockMethodVoid:block1 andNSString:block2 withParameter:string1];
    
    //                                                  *** STUDENT ***
    NSLog(@"\n\n\nLEVEL: STUDENT\n\n");
    RTStudent *student1 = [[RTStudent alloc] initWithName:@"Ruslan" andSurname:@"Timchenko"];
    RTStudent *student2 = [[RTStudent alloc] initWithName:@"Eduard" andSurname:@"Nugamanov"];
    RTStudent *student3 = [[RTStudent alloc] initWithName:@"Akram" andSurname:@"Makhmudov"];
    RTStudent *student4 = [[RTStudent alloc] initWithName:@"Dasha" andSurname:@"Timchenko"];
    RTStudent *student5 = [[RTStudent alloc] initWithName:@"Igor" andSurname:@"Tarasov"];
    RTStudent *student6 = [[RTStudent alloc] initWithName:@"Galya" andSurname:@"Tarasova"];
    
    NSArray *students = @[ student1, student2, student3, student4, student5, student6 ];
    
    NSArray *sortedStudents = [students sortedArrayUsingComparator:^NSComparisonResult(RTStudent *obj1, RTStudent *obj2) {
        
        if (obj1.surname != obj2.surname) {
            return [obj1.surname compare:obj2.surname];
        } else {
            return [obj1.name compare:obj2.name];
        }
        
    }];

    [self print:sortedStudents];
    //                                                  *** MASTER ***
    NSLog(@"\n\n\nLEVEL: MASTER\n\n");
    
    Doctor doctor = ^(RTPatient *patient){
        
        NSLog(@"Patient %@ feels bad :( .", patient.name);
        
        switch (patient.symptom) {
            case 0:
                NSLog(@"%@ has a sore throat", patient.name);
                NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                
                if (patient.temperature >= 36.f && patient.temperature < 38.f) {
                    [patient takePill];
                } else if (patient.temperature >= 38.f && patient.temperature < 41.f) {
                    [patient makeShot];
                }
                break;
                
            case 1:
                NSLog(@"%@ has a stomachache", patient.name);
                NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                
                if (patient.temperature <= 38.f) {
                    NSLog(@"You should have a rest\n\n");
                } else if (patient.temperature > 38.f) {
                    [patient makeShot];
                }
                break;
                
            case 2:
                NSLog(@"%@ has a headache", patient.name);
                NSLog(@"%@'s temperature is %f", patient.name, patient.temperature);
                
                [patient takePill];
                break;
        }
        
    };
    
    for (RTStudent *student in students) {
        if (![student howAreYou]) {
            [student doctorsBlock:doctor withPatient:student];
        }
    }
    //                                                  *** SUPERMAN ***
    NSLog(@"\n\n\nLEVEL: SUPERMAN\n\n");
    RTStudentSuperman *studentSuperman1 = [[RTStudentSuperman alloc] initWithName:@"Ruslan" andSurname:@"Timchenko"];
    RTStudentSuperman *studentSuperman2 = [[RTStudentSuperman alloc] initWithName:@"Eduard" andSurname:@"Nugamanov"];
    RTStudentSuperman *studentSuperman3 = [[RTStudentSuperman alloc] initWithName:@"Akram" andSurname:@"Makhmudov"];
    RTStudentSuperman *studentSuperman4 = [[RTStudentSuperman alloc] initWithName:@"Dasha" andSurname:@"Timchenko"];
    RTStudentSuperman *studentSuperman5 = [[RTStudentSuperman alloc] initWithName:@"Igor" andSurname:@"Tarasov"];
    RTStudentSuperman *studentSuperman6 = [[RTStudentSuperman alloc] initWithName:@"Galya" andSurname:@"Tarasova"];
    
    self.patients = @[ studentSuperman1, studentSuperman2, studentSuperman3, studentSuperman4, studentSuperman5, studentSuperman6 ];
    
    return YES;
    };

- (void) print:(NSArray *)students {
    for (RTStudent *student in students) {
        NSLog(@"%@ %@", student.name, student.surname);
    }
}

- (void) blockMethodVoid:(VoidBlock)block1 andNSString:(NSStringBlock)block2 withParameter:(NSString *)someString {
    block1();
    
    NSString *result = block2(someString);
    NSLog(@"%@", result);
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
