//
//  RTRandomColor.m
//  HW30
//
//  Created by Руслан on 05.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTRandomColor.h"

@implementation RTRandomColor

- (instancetype)initWithColorAndName
{
    self = [super init];
    if (self) {
        
        CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
        CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
        CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
        
        self.color = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
        
        self.name = [NSString stringWithFormat:@"RGB(%d, %d, %d)", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
        
    }
    return self;
}

@end
