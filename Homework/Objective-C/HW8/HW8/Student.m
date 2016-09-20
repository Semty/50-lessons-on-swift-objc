//
//  Student.m
//  HW8
//
//  Created by Руслан on 20.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Student.h"

@implementation Student

- (instancetype)initWithName:(NSString*)name andSurname:(NSString*)surname
{
    self = [super init];
    if (self) {
        self.name = name;
        self.surname = surname;
    }
    return self;
}

- (NSString*) sayHello {
    return @"Hello!";
}

@end
