//
//  RTBoxer.m
//  Lesson5
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTBoxer.h"

@implementation RTBoxer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Default name";
        self.height = 170.f;
        self.weight = 70.f;
        self.gender = @"Male";
        self.skinColor = @"White";
        self.nationality = @"Russian";
    }
    return self;
}


- (void) movement {
    [super movement];
    NSLog(@"Boxer is moving");
}

@end
