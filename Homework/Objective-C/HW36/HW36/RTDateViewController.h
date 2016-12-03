//
//  RTDateViewController.h
//  HW36
//
//  Created by Руслан on 28.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *dateOfBirthField;

@end

@interface RTDateViewController : UIViewController

@property (weak, nonatomic) id <ViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

- (IBAction)actionDateChanged:(UIDatePicker *)sender;
- (IBAction)actionDonePressed:(UIButton *)sender;

@end
