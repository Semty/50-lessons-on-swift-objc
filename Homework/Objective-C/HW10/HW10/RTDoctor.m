//
//  RTDoctor.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDoctor.h"
#import "RTGovernment.h"
#import "AppDelegate.h"

@interface RTDoctor ()

@property (assign, nonatomic) Float64 averagePrice;
@property (assign, nonatomic) Float64 infliation;

@end

@implementation RTDoctor

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"DefaultName";
        self.salary = 500.f;
        self.averagePrice = 10.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(salaryChangedNotification:)
                                                     name:RTGovernmentSalaryDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(averagePriceCgangedNotification:)
                                                     name:RTGovernmentAveragePriceDidChangeNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(DidEnterBackgroundNotification:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(WillEnterForegroundNotification:)
                                                     name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    }
    return self;
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Notifications

- (void) DidEnterBackgroundNotification:(NSNotification *)notification {
    NSLog(@"Doctor %@ go to sleep\n\n", self.name);
}

- (void) WillEnterForegroundNotification:(NSNotification *)notification {
    NSLog(@"Doctor %@ wakes up\n\n", self.name);
}

- (void) salaryChangedNotification:(NSNotification *)notification {
    
    NSNumber *numberSalary = notification.userInfo[RTGovernmentSalaryUserInfoKey];
    Float64 salary = [numberSalary floatValue];
    
    NSLog(@"\n\nDoctor:\nName - %@\nSalary before - %f $\nSalary now - %f $\n%@", self.name, self.salary, salary,
          self.salary <= salary ? @"Reaction: Happy. Salary is raised or similar!\n\n" : @"Reaction: Sad. Salary is decreased\n\n");
    
    self.salary = salary;
}

- (void) averagePriceCgangedNotification:(NSNotification *)notification {
    NSNumber *numberAveragePrice = notification.userInfo[RTGovernmentAveragePriceUserInfoKey];
    Float64 averagePrice = [numberAveragePrice floatValue];
    
    _infliation = (averagePrice - _averagePrice) / _averagePrice * 100;
    
    if (_infliation >= 0) {
        NSLog(@"%@: Average price: %f -> %f. Infliation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation <= 20) {
            NSLog(@"%f %@ is a normal situation in our world. To my mind, it's all ok\n\n", _infliation, @"%");
        } else {
            NSLog(@"%f %@... It's very difficult situation, but people continue to get sick.. Are you ok?\n\n", _infliation, @"%");
        }
    } else {
        _infliation = -_infliation;
        NSLog(@"%@: Average price: %f -> %f. Deflation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation <= 20) {
            NSLog(@"Deflation is very nice for me. Everytime\n\n");
        } else {
            NSLog(@"%f %@, wtf, why did my services become cheaper?\n\n", _infliation, @"%");
        }
    }
    
    _averagePrice = averagePrice;
}

@end
