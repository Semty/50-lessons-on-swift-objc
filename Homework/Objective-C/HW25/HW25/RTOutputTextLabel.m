//
//  RTOutputTextLabel.m
//  HW25
//
//  Created by Руслан on 24.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTOutputTextLabel.h"

@implementation RTOutputTextLabel

- (void)drawTextInRect:(CGRect)rect {
    UIEdgeInsets insetsNumbersInOutput = UIEdgeInsetsMake(CGRectGetHeight(rect) / 2,
                                                          0, 0, CGRectGetWidth(rect) / 10);
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, insetsNumbersInOutput)];
}

@end
