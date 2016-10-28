//
//  ViewController.m
//  ControlsTest
//
//  Created by Руслан on 28.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef enum {
    
    RTColorSchemeTypeRGB,
    RTColorSchemeTypeHSV
    
}RTColorSchemeType;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self refreshScreen];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

- (void) refreshScreen {
    
    CGFloat red = self.redComponentSlider.value;
    CGFloat green = self.greenComponentSlider.value;
    CGFloat blue = self.blueComponentSlider.value;
    
    UIColor *color = nil;
    
    if (self.colorSchemeControl.selectedSegmentIndex == RTColorSchemeTypeRGB) {
        
        color = [UIColor colorWithRed:red green:green blue:blue alpha:1.f];
    } else {
        
        color = [UIColor colorWithHue:red saturation:green brightness:blue alpha:1.f];
    }
    
    CGFloat hue, saturation, brightness, alpha;
    
    NSString *string = @"";
    
    if ([color getRed:&red green:&green blue:&blue alpha:&alpha]) {
        
        string = [string stringByAppendingFormat:@"RGB: {%0.2f, %0.2f, %0.2f}", red, green, blue];
    } else {
        string = [string stringByAppendingFormat:@"RGB: {NO DATA}"];
    }
    
    if ([color getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
        
        string = [string stringByAppendingFormat:@"\n HSV: {%0.2f, %0.2f, %0.2f}", hue, saturation, brightness];
    } else {
        
        string = [string stringByAppendingFormat:@"\n HSV: {NO DATA}"];
    }
    
    self.view.backgroundColor = color;
    
    self.infoLabel.text = string;
}

#pragma mark - Actions

- (IBAction)actionSlider:(UISlider *)sender {
    
    [self refreshScreen];
    
}

- (IBAction)actionEnable:(UISwitch *)sender {
    
    self.redComponentSlider.enabled = sender.isOn;
    self.greenComponentSlider.enabled = sender.isOn;
    self.blueComponentSlider.enabled = sender.isOn;
    
    self.enableLabel.text = sender.isOn == YES ? @"enabled" : @"disabled";
    
    /*
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
     */
    
}


@end
