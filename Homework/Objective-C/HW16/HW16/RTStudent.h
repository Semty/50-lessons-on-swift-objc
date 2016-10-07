//
//  RTStudent.h
//  HW16
//
//  Created by Руслан on 07.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTStudent : NSObject

@property (assign, nonatomic) NSDate *dateOfBirth;
@property (strong, nonatomic) NSString *studentAlias;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

- (instancetype) initWithAlias:(NSString *)someAlias;
- (void) createName;
- (void) createSurname;
- (void) createDateOfBirth;

@end
