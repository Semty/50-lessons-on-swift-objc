//
//  ViewController.m
//  HW26
//
//  Created by Руслан on 29.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) BOOL isAnimation;
@property (assign, nonatomic) NSTimeInterval speedAnimation;

@end

typedef enum {
    
    RTAnimalPo,
    RTAnimalTigress,
    RTAnimalShifu
    
}RTAnimal;

typedef enum {
 
    RTPointUp,
    RTPointDown
    
}RTPoint;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isAnimation = NO;
    self.speedAnimation = 1 / self.speedAnimationSlider.value;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (CGPoint) moveTo:(RTPoint)point {
    
    switch (point) {
        case RTPointUp:
            return CGPointMake(self.draggingView.bounds.origin.x,
                               self.draggingView.bounds.origin.y + 0.23 * CGRectGetHeight(self.draggingView.bounds));
            break;
        case RTPointDown:
            return CGPointMake(self.draggingView.bounds.origin.x,
                               self.draggingView.bounds.origin.y - 0.23 * CGRectGetHeight(self.draggingView.bounds));
            break;
    }
    
}

- (void) transformDraggingView {
    
    self.isAnimation = YES;
    
    CGAffineTransform translation = CGAffineTransformMakeTranslation(self.draggingView.bounds.origin.x,
                                                                     self.draggingView.bounds.origin.y);
    CGAffineTransform rotation = CGAffineTransformMakeRotation(0);
    CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
    
    if (self.rotationSwitch.isOn) {
        rotation = CGAffineTransformMakeRotation(M_PI);
    }
    
    if (self.scaleSwitch.isOn) {
        scale = CGAffineTransformMakeScale(1.25, 1.25);
    }
    
    if (self.translationSwitch.isOn) {
        CGPoint point = [self moveTo:arc4random()%2];
        translation = CGAffineTransformMakeTranslation(point.x, point.y);
    }
    
    CGAffineTransform transform = CGAffineTransformConcat(rotation, scale);
    transform = CGAffineTransformConcat(transform, translation);
    
        [UIView animateWithDuration:self.speedAnimation
                              delay:0
                            options:UIViewAnimationOptionCurveLinear
                         animations:^{
                             
                             self.draggingView.transform = transform;
                             
                         }
                         completion:^(BOOL finished) {
                             
                             [UIView animateWithDuration:self.speedAnimation
                                                   delay:0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  
                                                  self.draggingView.transform = CGAffineTransformIdentity;
                                                  
                                              }
                                              completion:^(BOOL finished) {
                                                  if (self.translationSwitch.isOn || self.scaleSwitch.isOn
                                                      || self.rotationSwitch.isOn) {
                                                      
                                                      [self transformDraggingView];
                                                  } else {
                                                      self.isAnimation = NO;
                                                  }
                                              }];
                         }];
}

- (void) changeImage:(RTAnimal)animal {
    
    switch (animal) {
        case RTAnimalPo:
            self.draggingView.image = [UIImage imageNamed:@"Po.jpg"];
            break;
        case RTAnimalShifu:
            self.draggingView.image = [UIImage imageNamed:@"Shifu.jpg"];
            break;
        case RTAnimalTigress:
            self.draggingView.image = [UIImage imageNamed:@"Tigress.jpg"];
            break;
        default:
            break;
    }
    
}

#pragma mark - Actions

- (IBAction)actionSwitch:(UISwitch *)sender {
    if (self.isAnimation == NO) {
        [self transformDraggingView];
    }
}

- (IBAction)actionSlider:(UISlider *)sender {
    self.speedAnimation = 1 / self.speedAnimationSlider.value;
    self.speedAnimationLabel.text = [NSString stringWithFormat:@"%1.1f", self.speedAnimation];
}

- (IBAction)actionSegmentedControl:(UISegmentedControl *)sender {
    [self changeImage:(int)sender.selectedSegmentIndex];
}

@end
