//
//  RTTableViewController.h
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTDateViewController.h"

@class RTStudent;

@interface RTTableViewController : UITableViewController <DateViewControllerDelegate>

@property (strong, nonatomic) RTStudent *student;

@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *gradeSlider;

- (IBAction)actionGenderChanged:(UISegmentedControl *)sender;
- (IBAction)actionGradeChanged:(UISlider *)sender;
- (IBAction)actionReset:(UIButton *)sender;

@end
