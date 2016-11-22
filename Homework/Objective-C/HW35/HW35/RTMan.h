//
//  RTStudent.h
//  HW35
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMan : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSDate *birthday;

+ (RTMan *) randomMan;
+ (NSArray *) randomPeopleWithNumber:(NSInteger)number;

@end
