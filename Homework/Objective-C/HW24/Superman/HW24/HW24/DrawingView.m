//
//  DrawingView.m
//  HW24
//
//  Created by Руслан on 22.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "DrawingView.h"

@implementation DrawingView

#pragma mark - Functions

- (void) drawLineFrom:(CGPoint)fromPoint to:(CGPoint)toPoint {
    
    CGColorRef color = [UIColor colorWithRed:self.delegate.redColor
                                       green:self.delegate.greenColor
                                        blue:self.delegate.blueColor alpha:1.f].CGColor;
    
    CGRect imageRect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.image drawInRect:imageRect];
    
    CGContextMoveToPoint(context, fromPoint.x, fromPoint.y);
    CGContextAddLineToPoint(context, toPoint.x, toPoint.y);
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.delegate.lineWidth);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextStrokePath(context);
    
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    self.alpha = self.delegate.opacity;
    UIGraphicsEndImageContext();
}

- (void) mergeTempView:(UIImageView *)tempView intoMainView:(UIImageView *)mainView {
    
    UIGraphicsBeginImageContext(mainView.frame.size);
    
    CGRect imageRect = CGRectMake(0, 0, CGRectGetWidth(mainView.frame), CGRectGetHeight(mainView.frame));
    imageRect = CGRectIntegral(imageRect);
    
    [mainView.image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:1.f];
    [tempView.image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:self.delegate.opacity];
    mainView.image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    tempView.image = nil;
}

- (void) drawPreview {
    
    self.image = nil;
    
    CGColorRef color = [UIColor colorWithRed:self.delegate.redColor
                                       green:self.delegate.greenColor
                                        blue:self.delegate.blueColor alpha:1.f].CGColor;
    
    CGRect imageRect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
    imageRect = CGRectIntegral(imageRect);
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.image drawInRect:imageRect];
    
    CGContextMoveToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    CGContextAddLineToPoint(context, CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, self.delegate.lineWidth);
    CGContextSetAlpha(context, self.delegate.opacity);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextStrokePath(context);
    
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}

#pragma mark - Draw rect
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end

