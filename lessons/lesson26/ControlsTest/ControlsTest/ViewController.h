//
//  ViewController.h
//  ControlsTest
//
//  Created by Руслан on 28.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *enableLabel;

@property (weak, nonatomic) IBOutlet UISlider *redComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenComponentSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueComponentSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSchemeControl;

- (IBAction)actionSlider:(UISlider *)sender;
- (IBAction)actionEnable:(UISwitch *)sender;

@end

