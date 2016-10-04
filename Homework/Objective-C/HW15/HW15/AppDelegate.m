//
//  AppDelegate.m
//  HW15
//
//  Created by Руслан on 04.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                              *** LEARNER ***
    
    RTStudent *student1 = [[RTStudent alloc] initWithName:@"Ruslan"];
    RTStudent *student2 = [[RTStudent alloc] initWithName:@"Eduard"];
    RTStudent *student3 = [[RTStudent alloc] initWithName:@"Akram"];
    RTStudent *student4 = [[RTStudent alloc] initWithName:@"Zahar"];
    RTStudent *student5 = [[RTStudent alloc] initWithName:@"Dasha"];
    
    NSMutableArray *students = [[NSMutableArray alloc] initWithObjects:
                                student1, student2, student3, student4, student5, nil];
    
    for (RTStudent *student in students) {
        [student setRandomSubjects];
    }
    NSLog(@"\n *** LEARNER *** %@", [self studentsInformation:students]);
    //                                              *** STUDENT ***
    
    NSMutableArray *humanitarians = [[NSMutableArray alloc] init];
    NSMutableArray *techies = [[NSMutableArray alloc] init];
    
    for (RTStudent *student in students) {
        
        BOOL direction = arc4random() % 2;
        
        if (direction) {
            [humanitarians addObject:student];
        } else {
            [techies addObject:student];
        }
    }
    
    NSLog(@"\n *** STUDENT *** \nHumanitarians:%@\nTechies:%@\nProgrammers = %ld person(s)\n\n\n",
          [self studentsInformation:humanitarians],
          [self studentsInformation:techies],
          [self howManyProgrammersIn:students]);
    
    //                                              *** MASTER ***
    
    [self biologistsDiscrimination:students];
    
    NSLog(@"\n *** MASTER *** %@", [self studentsInformation:students]);
    
    //                                              *** SUPERMAN ***
    
    NSMutableString *reversedBitsNumber = [NSMutableString string];
    NSMutableString *bitsNumber = [NSMutableString string];
    
    NSInteger randomNumber = arc4random();
    
    for (int i = 0; i < 32; i++) {
        
        if (randomNumber & (1 << i)) {
            [reversedBitsNumber appendString:@"1"];
        } else {
            [reversedBitsNumber appendString:@"0"];
        }
    }
    // reverse our string
    [reversedBitsNumber enumerateSubstringsInRange:NSMakeRange(0, [reversedBitsNumber length])
                                           options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences)
                                        usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                          [bitsNumber appendString:substring];
    }];
    
    NSLog(@"\n\n *** SUPERMAN *** \n\n%ld = %@\n\n\n", randomNumber, bitsNumber);
    
    return YES;
}

- (NSInteger) howManyProgrammersIn:(NSMutableArray *)array {
    NSInteger programmersCount = 0;
    
    for (RTStudent *student in array) {
        if (student.subjectType & RTStudentSubjectTypeDevelopment) {
            programmersCount += 1;
        }
    }
    return programmersCount;
}

- (void) biologistsDiscrimination:(NSMutableArray *)array {
    
    for (RTStudent *student in array) {
        
        if (student.subjectType & RTStudentSubjectTypeBiology) {
            
            student.subjectType &= ~RTStudentSubjectTypeBiology;
            
            NSLog(@"%@'s biology is deleted!", student.name);
        }
    }
}

- (NSString *) studentsInformation:(NSMutableArray *)array {
    
    NSString *resultString = @"";
    
    for (RTStudent *student in array) {
        resultString = [resultString stringByAppendingFormat:@"\n\n%@", student];
    }
    return resultString;
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
