//
//  RTGovernment.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTGovernment.h"
#import "AppDelegate.h"

NSString *const RTGovernmentTaxLevelDidChangeNotification = @"RTGovernmentTaxLevelDidChangeNotification";
NSString *const RTGovernmentSalaryDidChangeNotification = @"RTGovernmentSalaryDidChangeNotification";
NSString *const RTGovernmentPensionDidChangeNotification = @"RTGovernmentPensionDidChangeNotification";
NSString *const RTGovernmentAveragePriceDidChangeNotification = @"RTGovernmentAveragePriceDidChangeNotification";

NSString *const RTGovernmentTaxLevelUserInfoKey = @"RTGovernmentTaxLevelUserInfoKey";
NSString *const RTGovernmentSalaryUserInfoKey = @"RTGovernmentSalaryUserInfoKey";
NSString *const RTGovernmentPensionUserInfoKey = @"RTGovernmentPensionUserInfoKey";
NSString *const RTGovernmentAveragePriceUserInfoKey = @"RTGovernmentAveragePriceUserInfoKey";


@implementation RTGovernment

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.taxLevel = 13.f;
        self.salary = 500.f;
        self.pension = 200.f;
        self.averagePrice = 10.f;
        
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
    NSLog(@"\n\n\n");
    NSLog(@"Government go to sleep\n\n");
}

- (void) WillEnterForegroundNotification:(NSNotification *)notification {
    NSLog(@"Government wakes up\n\n");
}

- (void) setTaxLevel:(Float64)taxLevel {
    _taxLevel = taxLevel;
    
    NSDictionary *taxLevelDictionary = @{ RTGovernmentTaxLevelUserInfoKey: [NSNumber numberWithFloat:taxLevel] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RTGovernmentTaxLevelDidChangeNotification
                                                        object:nil
                                                      userInfo:taxLevelDictionary];
}

- (void) setSalary:(Float64)salary {
    _salary = salary;
    
    NSDictionary *salaryDictionary = @{ RTGovernmentSalaryUserInfoKey: [NSNumber numberWithFloat:salary] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RTGovernmentSalaryDidChangeNotification
                                                        object:nil
                                                      userInfo:salaryDictionary];
}

- (void) setPension:(Float64)pension {
    _pension = pension;
    
    NSDictionary *pansionDictionary = @{ RTGovernmentPensionUserInfoKey: [NSNumber numberWithFloat:pension] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RTGovernmentPensionDidChangeNotification
                                                        object:nil
                                                      userInfo:pansionDictionary];
}

- (void) setAveragePrice:(Float64)averagePrice {
    _averagePrice = averagePrice;
    
    NSDictionary *averagePriceDictionary = @{ RTGovernmentAveragePriceUserInfoKey: [NSNumber numberWithFloat:averagePrice] };
    
    [[NSNotificationCenter defaultCenter] postNotificationName:RTGovernmentAveragePriceDidChangeNotification
                                                        object:nil
                                                      userInfo:averagePriceDictionary];
}

@end
