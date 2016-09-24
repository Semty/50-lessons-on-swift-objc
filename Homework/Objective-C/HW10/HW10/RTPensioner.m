//
//  RTPensioner.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTPensioner.h"
#import "RTGovernment.h"
#import "AppDelegate.h"

@interface RTPensioner ()

@property (assign, nonatomic) Float64 averagePrice;
@property (assign, nonatomic) Float64 infliation;

@end

@implementation RTPensioner

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"DefaultName";
        self.pension = 200.f;
        self.averagePrice = 10.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(pensionChangedNotification:)
                                                     name:RTGovernmentPensionDidChangeNotification
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
    NSLog(@"Pensioner %@ go to sleep\n\n", self.name);
}

- (void) WillEnterForegroundNotification:(NSNotification *)notification {
    NSLog(@"Pensioner %@ wakes up\n\n", self.name);
}

- (void) pensionChangedNotification:(NSNotification *)notification {
    
    NSNumber *numberPension = notification.userInfo[RTGovernmentPensionUserInfoKey];
    Float64 pension = [numberPension floatValue];
    
    NSLog(@"\n\nPensioner:\nName - %@\nPension before - %f $\nPension now - %f $\n%@", self.name, self.pension, pension,
          self.pension <= pension ? @"Reaction: Happy. Pension is raised or similar!\n\n": @"Reaction: Sad. Pension is decreased\n\n");
    
    self.pension = pension;
    
}

- (void) averagePriceCgangedNotification:(NSNotification *)notification {
    NSNumber *numberAveragePrice = notification.userInfo[RTGovernmentAveragePriceUserInfoKey];
    Float64 averagePrice = [numberAveragePrice floatValue];
    
    _infliation = (averagePrice - _averagePrice) / _averagePrice * 100;
    
    if (_infliation >= 0) {
        NSLog(@"%@: Average price: %f -> %f. Infliation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation <= 20) {
            NSLog(@"I think that infiation with level on %f %@ doesn't kill me..\n\n", _infliation, @"%");
        } else {
            NSLog(@"%f %@! Oh my God!! How should I live?!\n\n", _infliation, @"%");
        }
    } else {
        _infliation = -_infliation;
        NSLog(@"%@: Average price: %f -> %f. Deflation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation <= 20) {
            NSLog(@"I see a low level of deflation ( <= 20 ). Nevermind, it is good))\n\n");
        } else {
            NSLog(@"RUSH A SHOP! WHERE ARE MY POTATOES??!\n\n");
        }
    }
    
    _averagePrice = averagePrice;
}

@end
