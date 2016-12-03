//
//  ViewController.h
//  HW36
//
//  Created by Руслан on 28.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTDateViewController.h"
#import "RTEducationViewController.h"

@interface ViewController : UITableViewController <ViewControllerDelegate, EducationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (weak, nonatomic) IBOutlet UITextField *educationField;

- (IBAction)actionSaveInfo:(UIButton *)sender;
- (IBAction)actionDeleteAll:(UIButton *)sender;

- (void) saveInfo;
- (void) loadInfo;

@end

