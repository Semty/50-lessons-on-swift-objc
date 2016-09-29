//
//  RTStudentSuperman.m
//  HW12
//
//  Created by Руслан on 29.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTStudentSuperman.h"

@implementation RTStudentSuperman
@synthesize name = _name;

- (instancetype)initWithName:(NSString *)name andSurname:(NSString *)surname
{
    self = [super init];
    if (self) {
        _name = name;
        _surname = surname;
    }
    return self;
}

/*- (void) dealloc {
    NSLog(@"\n\nFUCK!!!\n\n");
}*/

@end
