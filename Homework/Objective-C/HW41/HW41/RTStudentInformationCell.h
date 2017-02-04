//
//  RTStudentInformationCell.h
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTStudentInformationCell : UITableViewCell

@property (assign, nonatomic) BOOL firstNameIsOk;
@property (assign, nonatomic) BOOL lastNameIsOk;
@property (assign, nonatomic) BOOL emailIsOk;

@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;

@property (weak, nonatomic) IBOutlet UIImageView *firstNameIsOkImage;
@property (weak, nonatomic) IBOutlet UIImageView *lastNameIsOkImage;
@property (weak, nonatomic) IBOutlet UIImageView *emailIsOkImage;

@end
