//
//  RTAnimal.m
//  Lesson5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTAnimal.h"

@implementation RTAnimal

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.species = @"Some animal";
        self.name = @"Default name";
        self.age = 5;
    }
    return self;
}

- (void) movement {
    NSLog(@"Animal is moving");
}

@end
