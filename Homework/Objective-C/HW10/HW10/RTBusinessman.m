//
//  RTBusinessman.m
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTBusinessman.h"
#import "RTGovernment.h"
#import "AppDelegate.h"

@interface RTBusinessman ()

@property (assign, nonatomic) Float64 averagePrice;
@property (assign, nonatomic) Float64 infliation;

@end

@implementation RTBusinessman

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"DefaultName";
        self.taxLevel = 13.f;
        self.averagePrice = 10.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(taxLevelChangedNotification:)
                                                     name:RTGovernmentTaxLevelDidChangeNotification
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
    NSLog(@"Businessman %@ go to sleep\n\n\n\n", self.name);
}

- (void) WillEnterForegroundNotification:(NSNotification *)notification {
    NSLog(@"Businessman %@ wakes up\n\n", self.name);
}

- (void) taxLevelChangedNotification:(NSNotification *)notification {
    
    NSNumber *numberTaxLevel = notification.userInfo[RTGovernmentTaxLevelUserInfoKey];
    Float64 taxLevel = [numberTaxLevel floatValue];
    
    NSLog(@"\n\nBusinessman:\nName - %@\nTax level before - %f %@\nTax level now - %f %@\n%@", self.name, self.taxLevel,
          @"%", taxLevel, @"%",
          self.taxLevel >= taxLevel ? @"Reaction: Happy. Tax level is decreased or similar!\n\n" : @"Reaction: Sad. Tax level is raised!\n\n");
    
    _taxLevel = taxLevel;
    
}

- (void) averagePriceCgangedNotification:(NSNotification *)notification {
    NSNumber *numberAveragePrice = notification.userInfo[RTGovernmentAveragePriceUserInfoKey];
    Float64 averagePrice = [numberAveragePrice floatValue];
    
    _infliation = (averagePrice - _averagePrice) / _averagePrice * 100;
    
    if (_infliation >= 0) {
        NSLog(@"%@: Average price: %f -> %f. Infliation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation >= 20) {
            NSLog(@"%f %@ it's too hard for me...\n\n\n\n\n", _infliation, @"%");
        } else {
            NSLog(@"%f %@.. I suppose, I'll can overcome\n\n\n\n\n", _infliation, @"%");
        }
    } else {
        _infliation = -_infliation;
        NSLog(@"%@: Average price: %f -> %f. Deflation: %f %@\n", _name, _averagePrice, averagePrice, _infliation, @"%");
        if (_infliation <= 20) {
            NSLog(@"Situation with %f %@ deflation's is very convinient for me\n\n\n\n\n", _infliation, @"%");
        } else {
            NSLog(@"Fuck! %f %@ it's a hell! My goods become cheaper!\n\n\n\n\n", _infliation, @"%");
        }
    }
    
    _averagePrice = averagePrice;
}

@end
