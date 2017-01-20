//
//  RTStudent.h
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    
    RTMan,
    RTWoman
    
} RTGender;

@interface RTStudent : NSObject

@property (weak, nonatomic) RTStudent *friend;

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSDate *dateOfBirth;

@property (assign, nonatomic) RTGender gender;
@property (assign, nonatomic) double grade;

- (void) resetAllProperties;

@end
