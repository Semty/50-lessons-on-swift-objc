//
//  RTHuman.m
//  Lesson5
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTHuman.h"

@implementation RTHuman

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Default name";
        self.height = 170.f;
        self.weight = 70.f;
        self.gender = @"Male";
    }
    return self;
}

- (void) movement {
    NSLog(@"Human is moving");
}

@end
