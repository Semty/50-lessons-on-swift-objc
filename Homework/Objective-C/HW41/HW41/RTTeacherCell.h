//
//  RTTeacherCell.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTTeacherViewController.h"

@class RTStudent;

@interface RTTeacherCell : UITableViewCell <RTTeacherProtocol>

@property (weak, nonatomic) IBOutlet UITextField *teacherField;
@property (weak, nonatomic) RTStudent *teacher;
@property (assign, nonatomic) NSInteger selectedRow;

@end
