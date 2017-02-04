//
//  RTCoursesNameAndSubjectCell.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTCoursesNameAndSubjectCell : UITableViewCell

@property (assign, nonatomic) BOOL nameIsOk;
@property (assign, nonatomic) BOOL subjectIsOk;

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *subjectField;

@property (weak, nonatomic) IBOutlet UIImageView *nameIsOkImage;
@property (weak, nonatomic) IBOutlet UIImageView *subjectIsOkImage;

@end
