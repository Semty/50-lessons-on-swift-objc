//
//  AppDelegate.m
//  HW9
//
//  Created by Руслан on 21.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "Patient.h"
#import "Doctor.h"
#import "BadDoctor.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                      *** LEARNER ***
    Patient* patient1 = [[Patient alloc] init];
    Patient* patient2 = [[Patient alloc] init];
    Patient* patient3 = [[Patient alloc] init];
    Patient* patient4 = [[Patient alloc] init];
    Patient* patient5 = [[Patient alloc] init];
    
    Doctor* doctor = [[Doctor alloc] init];
    doctor.name = @"Nastya";
    
    patient1.name = @"Ruslan";
    //patient1.delegate = doctor;
    
    patient2.name = @"Eduard";
    patient2.delegate = doctor;
    
    patient3.name = @"Akram";
    //patient3.delegate = doctor;
    
    patient4.name = @"Igor";
    patient4.delegate = doctor;
    
    patient5.name = @"Zahar";
    //patient5.delegate = doctor;
    
    /*NSArray* patients = @[ patient1, patient2, patient3, patient4, patient5 ];
    
    for (Patient* patient in patients) {
        [patient howAreYou];
        NSLog(@"\n\n");
    }*/
    //                                   ***   STUDENT   ***
    BadDoctor* badDoctor1 = [[BadDoctor alloc] init];
    BadDoctor* badDoctor2 = [[BadDoctor alloc] init];
    
    badDoctor1.name = @"Maksim";
    badDoctor2.name = @"Zhenya";
    
    patient1.delegate = badDoctor1;
    patient3.delegate = badDoctor2;
    patient5.delegate = badDoctor1;
    
    /*NSArray* patients = @[ patient1, patient2, patient3, patient4, patient5 ];
    
    NSLog(@"\n\n\n"); // We see a lot of rubbish of console in Xcode 8
    
    for (Patient* patient in patients) {
        [patient howAreYou];
        NSLog(@"\n\n");
    }*/
    //                                      ***   MASTER && SUPERMAN ***

    Patient* patient6 = [[Patient alloc] init];
    Patient* patient7 = [[Patient alloc] init];
    Patient* patient8 = [[Patient alloc] init];
    
    patient6.name = @"Dasha";
    patient6.delegate = doctor;
    
    patient7.name = @"Misha";
    patient7.delegate = doctor;
    
    patient8.name = @"Ilya";
    patient8.delegate = doctor;
    
    NSArray* patients = @[ patient1, patient2, patient3, patient4, patient5, patient6, patient7, patient8 ];
    NSArray* doctors = @[ doctor, badDoctor1, badDoctor2 ];
    
    NSLog(@"\n\n\n                                                          *** DAY 1 ***\n\n\n");
    for (Patient* patient in patients) {
        [patient howAreYou];
        NSLog(@"\n\n");
    }
    
    [doctor report];
    [badDoctor1 report];
    [badDoctor2 report];
    
    NSLog(@"\n");
    
    for (Patient* patient in patients) {
        if (patient.feedback == dislike) {
            NSLog(@"%@ dislikes his doctor. He'll change him", patient.name);
            [patient change:patient.delegate from:doctors];
        }
    }
    
    [doctor clearCount];
    [badDoctor1 clearCount];
    [badDoctor2 clearCount];
    
    NSLog(@"\n\n\n                                                          *** DAY 2 ***\n\n\n");
    for (Patient* patient in patients) {
        [patient howAreYou];
        NSLog(@"\n\n");
    }
    
    NSLog(@"\n\n");
    
    [doctor report];
    [badDoctor1 report];
    [badDoctor2 report];
    
    NSLog(@"\n\n\n");
    
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
