//
//  Doctor.m
//  NotificationsTest
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Doctor.h"
#import "Government.h"

@implementation Doctor

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(salaryChangedNotification:)
                                                     name:GovernmentSalaryDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceChangedNotification:)
                                                     name:GovernmentAveragePriceDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) salaryChangedNotification:(NSNotification *)notification {
    
    NSNumber *value = notification.userInfo[GovernmentSalaryUserInfoKey];
    
    Float64 salary = [value floatValue];
    
    if (salary < self.salary) {
        NSLog(@"Doctors are not happy\n\n                                                                                         Salary %f > %f", _salary, salary);
    } else {
        NSLog(@"Doctors are happy\n\n                                                                                                Salary %f < %f", _salary, salary);
    }
    self.salary = salary;
    
}

- (void) averagePriceChangedNotification:(NSNotification *)notification {
    
}

@end
