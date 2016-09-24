//
//  Government.m
//  NotificationsTest
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Government.h"

NSString *const GovernmentTaxLevelDidChangeNotification = @"GovernmentTaxLevelDidChangeNotification";
NSString *const GovernmentSalaryDidChangeNotification = @"GovernmentSalaryDidChangeNotification";
NSString *const GovernmentPensionDidChangeNotification = @"GovernmentPensionDidChangeNotification";
NSString *const GovernmentAveragePriceDidChangeNotification = @"GovernmentAveragePriceDidChangeNotification";

NSString *const GovernmentTaxLevelUserInfoKey = @"GovernmentTaxLevelUserInfoKey";
NSString *const GovernmentSalaryUserInfoKey = @"GovernmentSalaryUserInfoKey";
NSString *const GovernmentPensionUserInfoKey = @"GovernmentPensionUserInfoKey";
NSString *const GovernmentAveragePriceUserInfoKey = @"GovernmentAveragePriceUserInfoKey";

@implementation Government

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taxLevel = 5.f;
        self.salary = 1000.f;
        self.pension = 500.f;
        self.averagePrice = 10.f;

    }
    return self;
}

- (void) setTaxLevel:(Float64)taxLevel {
    _taxLevel = taxLevel;
    
    NSDictionary *dictionary = @{ GovernmentTaxLevelUserInfoKey: [NSNumber numberWithFloat:taxLevel] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setSalary:(Float64)salary {
    _salary = salary;
    
    NSDictionary *dictionary = @{ GovernmentSalaryUserInfoKey: [NSNumber numberWithFloat:salary] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setPension:(Float64)pension {
    _pension = pension;
    
    NSDictionary *dictionary = @{ GovernmentPensionUserInfoKey: [NSNumber numberWithFloat:pension] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

- (void) setAveragePrice:(Float64)averagePrice {
    _averagePrice = averagePrice;
    
    NSDictionary *dictionary = @{ GovernmentAveragePriceUserInfoKey: [NSNumber numberWithFloat:averagePrice] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:GovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:dictionary];
}

@end
