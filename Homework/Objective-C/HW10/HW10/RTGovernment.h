//
//  RTGovernment.h
//  HW10
//
//  Created by Руслан on 24.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const RTGovernmentTaxLevelDidChangeNotification;
extern NSString *const RTGovernmentSalaryDidChangeNotification;
extern NSString *const RTGovernmentPensionDidChangeNotification;
extern NSString *const RTGovernmentAveragePriceDidChangeNotification;

extern NSString *const RTGovernmentTaxLevelUserInfoKey;
extern NSString *const RTGovernmentSalaryUserInfoKey;
extern NSString *const RTGovernmentPensionUserInfoKey;
extern NSString *const RTGovernmentAveragePriceUserInfoKey;

@interface RTGovernment : NSObject

@property (assign, nonatomic) Float64 taxLevel;
@property (assign, nonatomic) Float64 salary;
@property (assign, nonatomic) Float64 pension;
@property (assign, nonatomic) Float64 averagePrice;

@end
