//
//  RTObject.m
//  ArraysTest
//
//  Created by Руслан on 15.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTObject.h"

@implementation RTObject

- (void) action {
    NSLog(@"%@ ACTION!!!", self.name.uppercaseString);
}

@end
