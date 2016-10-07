//
//  AppDelegate.m
//  HW16
//
//  Created by Руслан on 07.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "AppDelegate.h"
#import "RTStudent.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSMutableArray *students;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //                                                  *** LEARNER && STUDENT ***
    self.students = [[NSMutableArray alloc] init];
        
    _students = [self createStudents:30];
    
    [_students sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        
        RTStudent *student1 = obj1;
        RTStudent *student2 = obj2;
        
        return [student2.dateOfBirth compare:student1.dateOfBirth];
        
    }];
    
    [self printStudents:_students];
    //                                                  *** MASTER && SUPERMAN ***
    
    __block NSDate *timerDate = [NSDate dateWithTimeIntervalSinceNow:-(1072224000 + 504576000)];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        timerDate = [timerDate dateByAddingTimeInterval:86400];
        NSLog(@"%@", timerDate);
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *components = [[NSDateComponents alloc] init];
        
        NSDateFormatter *anotherFormatter = [[NSDateFormatter alloc] init];
        [anotherFormatter setDateFormat:@"EEEE"];
        NSString *nameOfDay = [anotherFormatter stringFromDate:timerDate];
        
        components = [calendar components:NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday
                                 fromDate:timerDate];
        
        if (components.day == 01) {
            
            NSLog(@"%ld.%ld - %@. It's the first day of the month!!!", components.day, components.month, nameOfDay);
        }
        
        if ([nameOfDay isEqualToString:@"Sunday"]) {
            NSLog(@"%ld.%ld - Sunday!", components.month, components.day);
        }
        
        for (RTStudent *student in _students) {
            
            NSDateFormatter *someFormatter = [[NSDateFormatter alloc] init];
            [someFormatter setDateFormat:@"dd.MM.yyyy"];
            
            NSString *dateOfStudent = [someFormatter stringFromDate:student.dateOfBirth];
            NSString *dateOfTimer = [someFormatter stringFromDate:timerDate];
            
            if ([dateOfTimer isEqualToString:@"01.11.2000"]) {
                [timer invalidate];
            }
            
            if ([dateOfTimer isEqualToString:dateOfStudent]) {
                
                NSLog(@"\n\n\n\n%@ %@, HAPPY BIRTHDAY!!!\n\n\n", student.name, student.surname);
                
            }
        }
    }];
    
    [timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    
    [self compareAgeOf:[_students firstObject] and:[_students lastObject]];

    return YES;
}

- (NSMutableArray *) createStudents:(NSInteger)amount {
    
    NSMutableArray *tempStudents = [[NSMutableArray alloc] init];
    
    for (uint i = 0; i < amount ; i++) {
        RTStudent *someStudent = [[RTStudent alloc] initWithAlias:[NSString stringWithFormat:@"student%d", i + 1]];
        [someStudent createName];
        [someStudent createSurname];
        [someStudent createDateOfBirth];
        [tempStudents addObject:someStudent];
    }
    return tempStudents;
}

- (void) printStudents:(NSMutableArray *)students {
    
    for (RTStudent *student in students) {
        
        NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
        [tempFormatter setDateFormat:@"dd.MM.yyyy"];
        
        NSString *dateOfBirth = [tempFormatter stringFromDate:student.dateOfBirth];
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
        
        NSDateComponents *age = [[NSDateComponents alloc] init];
        age = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth
                          fromDate:student.dateOfBirth
                            toDate:[tempFormatter dateFromString:@"01.11.2016"]
                           options:0];
        
        NSLog(@"\n\n\nAlias: %@\nFullname: %@ %@\nDate of birth: %@ (%ld years and %ld months)\n\n",
              student.studentAlias, student.name, student.surname, dateOfBirth, age.year, age.month);
        
    }
    
}

- (void) compareAgeOf:(RTStudent *)student1 and:(RTStudent *)student2 {
    
    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc] init];
    [tempFormatter setDateFormat:@"dd.MM.yyyy"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *age = [[NSDateComponents alloc] init];
    age = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth |NSCalendarUnitDay
                      fromDate:student1.dateOfBirth
                        toDate:student2.dateOfBirth
                       options:0];
    
    NSLog(@"\n\n\nThe youngest: %@ %@, the oldest: %@ %@; Age difference = %ld year(s), %ld month(s), %ld week(s), %ld day(s)\n\n\n",
          student1.name, student1.surname, student2.name, student2.surname, -age.year, -age.month, -age.weekOfMonth, -age.day);
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
