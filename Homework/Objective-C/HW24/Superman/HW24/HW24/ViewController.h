//
//  ViewController.h
//  HW24
//
//  Created by Руслан on 22.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawingView.h"

@interface ViewController : UIViewController <DrawingViewDelegate>

@property (assign, nonatomic) CGPoint lastPoint;
@property (assign, nonatomic) CGFloat redColor;
@property (assign, nonatomic) CGFloat greenColor;
@property (assign, nonatomic) CGFloat blueColor;
@property (assign, nonatomic) CGFloat opacity;
@property (assign, nonatomic) CGFloat lineWidth;

@end

