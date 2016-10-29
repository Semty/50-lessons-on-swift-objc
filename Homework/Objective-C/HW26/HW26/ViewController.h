//
//  ViewController.h
//  HW26
//
//  Created by Руслан on 29.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *draggingView;

@property (weak, nonatomic) IBOutlet UISwitch *rotationSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *scaleSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *translationSwitch;
@property (weak, nonatomic) IBOutlet UISlider *speedAnimationSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *speedAnimationLabel;

- (IBAction)actionSwitch:(UISwitch *)sender;
- (IBAction)actionSlider:(UISlider *)sender;
- (IBAction)actionSegmentedControl:(UISegmentedControl *)sender;


@end

