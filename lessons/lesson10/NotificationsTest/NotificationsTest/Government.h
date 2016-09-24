//
//  Government.h
//  NotificationsTest
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const GovernmentTaxLevelDidChangeNotification;
extern NSString *const GovernmentSalaryDidChangeNotification;
extern NSString *const GovernmentPensionDidChangeNotification;
extern NSString *const GovernmentAveragePriceDidChangeNotification;

extern NSString *const GovernmentTaxLevelUserInfoKey;
extern NSString *const GovernmentSalaryUserInfoKey;
extern NSString *const GovernmentPensionUserInfoKey;
extern NSString *const GovernmentAveragePriceUserInfoKey;

@interface Government : NSObject

@property (assign, nonatomic) Float64 taxLevel;
@property (assign, nonatomic) Float64 salary;
@property (assign, nonatomic) Float64 pension;
@property (assign, nonatomic) Float64 averagePrice;

@end
