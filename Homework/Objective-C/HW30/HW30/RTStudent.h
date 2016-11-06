//
//  RTStudent.h
//  HW30
//
//  Created by Руслан on 06.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *fullName;
@property (assign, nonatomic) float averageMark;

- (NSString *) randomFirstName;
- (NSString *) randomLastName;
- (float) randomMark;

- (instancetype) initWithFullNameAndAvMark;

@end
