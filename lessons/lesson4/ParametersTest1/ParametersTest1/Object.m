//
//  Object.m
//  ParametersTest1
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "Object.h"

@implementation Object

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"object is created");
    }
    return self;
}

- (void) dealloc {
    NSLog(@"object is deallocated");
}
- (void) sayHello {
    NSLog(@"Hello!");
}

- (instancetype) copyWithZone:(NSZone *)zone {
    return [[Object alloc] init];
}

@end
