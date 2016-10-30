//
//  ViewController.h
//  TextFields1Test
//
//  Created by Руслан on 30.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;

- (IBAction)actionLog:(UIButton *)sender;
- (IBAction)actionTextChanged:(UITextField *)sender;

@end

