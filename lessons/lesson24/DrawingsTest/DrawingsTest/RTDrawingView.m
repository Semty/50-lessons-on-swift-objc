//
//  RTDrawingView.m
//  DrawingsTest
//
//  Created by Руслан on 19.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDrawingView.h"

@implementation RTDrawingView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.


- (void)drawRect:(CGRect)rect {
    // Drawing code
    //[super drawRect:rect];
    
    
    
    NSLog(@"drawRect %@", NSStringFromCGRect(rect));
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*
     
     CGRect square1 = CGRectMake(100, 100, 100, 100);
     CGRect square2 = CGRectMake(200, 200, 100, 100);
     CGRect square3 = CGRectMake(300, 300, 100, 100);
     
    //CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    
    
    //CGContextAddRect(context, rect);
    //CGContextFillPath(context);
    //CGContextFillRect(context, rect);
    
    
    CGContextAddRect(context, square1);
    CGContextAddRect(context, square2);
    CGContextAddRect(context, square3);
    
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, [UIColor greenColor].CGColor);
    
    CGContextAddEllipseInRect(context, square1);
    CGContextAddEllipseInRect(context, square2);
    CGContextAddEllipseInRect(context, square3);
    
    CGContextFillPath(context);
    
    
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    
    CGContextSetLineWidth(context, 2.f);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddLineToPoint(context, CGRectGetMinX(square3), CGRectGetMaxY(square3));
    
    CGContextStrokePath(context);
    
    
    CGContextMoveToPoint(context, CGRectGetMaxX(square1), CGRectGetMinY(square1));
    CGContextAddLineToPoint(context, CGRectGetMaxX(square3), CGRectGetMinY(square3));
    
    CGContextStrokePath(context);
    
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    
    CGContextMoveToPoint(context, CGRectGetMinX(square1), CGRectGetMaxY(square1));
    CGContextAddArc(context, CGRectGetMaxX(square1), CGRectGetMaxY(square1),
                    CGRectGetWidth(square1), M_PI, 0, YES);
    
    CGContextStrokePath(context);
    
    
    CGContextMoveToPoint(context, CGRectGetMinX(square2), CGRectGetMaxY(square2));
    CGContextAddArc(context, CGRectGetMaxX(square2), CGRectGetMaxY(square2),
                    CGRectGetWidth(square2), 0, M_PI, YES);
    
    CGContextStrokePath(context);

    
    NSString *text = @"Test";
    
    UIFont *font = [UIFont systemFontOfSize:14.f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(1.f, 1.f);
    shadow.shadowColor = [UIColor whiteColor];
    shadow.shadowBlurRadius = 0.5f;
    
    NSDictionary *attributes = @{ NSForegroundColorAttributeName: [UIColor blackColor],
                                  NSFontAttributeName: font,
                                  NSShadowAttributeName: shadow };
    
    CGSize textSize = [text sizeWithAttributes:attributes];
    CGRect textRect = CGRectMake(CGRectGetMidX(square2) - textSize.width / 2,
                                 CGRectGetMidY(square2) - textSize.height / 2,
                                 textSize.width, textSize.height);
    
    textRect = CGRectIntegral(textRect);
    
    [text drawInRect:textRect withAttributes:attributes];
    
    //[text drawAtPoint:CGPointMake(CGRectGetMidX(square2) - textSize.width / 2,
    //                              CGRectGetMidY(square2) - textSize.height / 2)
    //   withAttributes:attributes];
    
    */
    
    
    CGFloat offset = 5;
    CGFloat border = 2;
    
    CGFloat maxBoardSize = MIN(CGRectGetWidth(rect) - offset * 2 - border * 2,
                               CGRectGetHeight(rect)) - offset * 2 - border * 2;
    
    int cellSize = (int)maxBoardSize / 8;
    int boardSize = cellSize * 8;
    
    CGRect boardRect = CGRectMake((CGRectGetWidth(rect) - boardSize) / 2,
                                  (CGRectGetHeight(rect) - boardSize) / 2,
                                  boardSize, boardSize);
    
    boardRect = CGRectIntegral(boardRect);
    
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            
            if (i % 2 != j % 2) {
                CGRect cellRect = CGRectMake(CGRectGetMinX(boardRect) + i * cellSize,
                                             CGRectGetMinY(boardRect) + j * cellSize,
                                             cellSize, cellSize);
                CGContextAddRect(context, cellRect);
            }
            
        }
    }
    
    CGContextSetFillColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextFillPath(context);
    
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextAddRect(context, boardRect);
    CGContextSetLineWidth(context, border);
    CGContextStrokePath(context);
}


@end
