//
//  RTStudentSuperman.h
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RTPatientSuperman.h"

@interface RTStudentSuperman : RTPatientSuperman

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *surname;

- (instancetype) initWithName:(NSString *)name andSurname:(NSString *)surname;

@end

