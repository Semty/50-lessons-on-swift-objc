//
//  RTDrawingView.m
//  HW24
//
//  Created by Руслан on 20.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDrawingView.h"

@interface RTDrawingView()

@property (strong, nonatomic) NSMutableArray *rects;

@end

@implementation RTDrawingView

#pragma mark - Draw rect

- (void)drawRect:(CGRect)rect {
    
    self.rects = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        [self createStarInsideMainRect:rect withCoeff:2.8];
    }
    
}

#pragma mark - Helpful functions

- (UIColor *) randomColor {
    
    CGFloat r = (CGFloat)(arc4random() % 256) / 255;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];
}

- (BOOL) placeIsFreeFor:(CGRect)newRect amongRects:(NSMutableArray *)rects {
    
    for (NSString *stringRect in rects) {
        
        CGRect currentRect = CGRectFromString(stringRect);
        
        if (CGRectIntersectsRect(currentRect, newRect)) {
            return NO;
        }
        
    }
    
    return YES;
}

- (CGRect) createRandomRectInsideMainRect:(CGRect)rect withCoeff:(CGFloat)coeff {
    
    CGFloat size = MIN(CGRectGetWidth(rect), CGRectGetHeight(rect)) / coeff;
    
    CGFloat pointX = arc4random_uniform((UInt32)CGRectGetMaxX(rect) - size);
    CGFloat pointY = arc4random_uniform((UInt32)CGRectGetMaxY(rect) - size);
    CGRect rectOfStar = CGRectMake(pointX, pointY, size, size);
    
    while (![self placeIsFreeFor:rectOfStar amongRects:self.rects]) {
        
        pointX = arc4random_uniform((UInt32)CGRectGetMaxX(rect) - size);
        pointY = arc4random_uniform((UInt32)CGRectGetMaxY(rect) - size);
        rectOfStar = CGRectMake(pointX, pointY, size, size);
        
    }
    [self.rects addObject:NSStringFromCGRect(rectOfStar)];
    return rectOfStar;
}

- (void) createStarInsideMainRect:(CGRect)mainRect withCoeff:(CGFloat)coeff {
    
    CGRect rectOfStar = [self createRandomRectInsideMainRect:mainRect withCoeff:coeff];
    
    CGFloat radiusStar = CGRectGetWidth(rectOfStar) / 2;
    CGFloat centerX = CGRectGetMidX(rectOfStar);
    CGFloat centerY = CGRectGetMidY(rectOfStar);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint vertexStar;
    CGFloat angle = (4 * M_PI) / 5;
    
    CGContextSetLineWidth(context, 2.5);
    CGContextSetStrokeColorWithColor(context, [self randomColor].CGColor);
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    
    // draw the star
    
    CGContextMoveToPoint(context, centerX, centerY - radiusStar);
    
    for (int i = 1; i < 6; i++) {
        
        vertexStar.x = radiusStar * sin(i * angle);
        vertexStar.y = radiusStar * cos(i * angle);
        
        CGContextAddLineToPoint(context, centerX + vertexStar.x, centerY - vertexStar.y);
    }
    CGContextFillPath(context);
    
    // draw lines
    
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    CGContextMoveToPoint(context, centerX, centerY - radiusStar);
    
    for (int i = 1; i < 6; i++) {
        
        vertexStar.x = radiusStar * sin(i * angle / 2);
        vertexStar.y = radiusStar * cos(i * angle / 2);
        
        CGPoint point = CGPointMake(centerX + vertexStar.x, centerY - vertexStar.y);
        CGContextAddLineToPoint(context, point.x, point.y);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, point.x, point.y);
    }
    
    // draw circles
    
    CGContextSetFillColorWithColor(context, [self randomColor].CGColor);
    CGContextMoveToPoint(context, centerX, centerY - radiusStar);
    
    for (int i = 1; i < 6; i++) {
        
        vertexStar.x = radiusStar * sin(i * angle / 2);
        vertexStar.y = radiusStar * cos(i * angle / 2);
        
        CGPoint point = CGPointMake(centerX + vertexStar.x, centerY - vertexStar.y);
        CGFloat sizeRect = radiusStar / 5;
        CGContextAddEllipseInRect(context, CGRectMake(point.x - sizeRect / 2,
                                                      point.y - sizeRect / 2,
                                                      sizeRect, sizeRect));
        CGContextFillPath(context);
        
        CGContextMoveToPoint(context, point.x, point.y);
    }

}


@end
