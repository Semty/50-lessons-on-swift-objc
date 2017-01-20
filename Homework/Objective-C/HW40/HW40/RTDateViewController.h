//
//  RTDateViewController.h
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTStudent;

@protocol DateViewControllerDelegate <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;
@property (strong, nonatomic) RTStudent *student;

@end

@interface RTDateViewController : UIViewController

@property (weak, nonatomic) id <DateViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionDateChanged:(UIDatePicker *)sender;
- (IBAction)actionDonePressed:(UIButton *)sender;

@end
