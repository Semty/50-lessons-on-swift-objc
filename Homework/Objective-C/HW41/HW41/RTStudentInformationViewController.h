//
//  RTStudentInformationViewController.h
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTStudentInformationCell.h"

@class RTPersonCell;

@interface RTStudentInformationViewController : UITableViewController

@property (strong, nonatomic) NSString *titleName;
@property (weak, nonatomic) RTPersonCell *editCell;

@property (weak, nonatomic) RTStudentInformationCell *studentfirstName;
@property (weak, nonatomic) RTStudentInformationCell *studentLastName;
@property (weak, nonatomic) RTStudentInformationCell *studentEmail;

- (IBAction)actionSaveData:(UIBarButtonItem *)sender;

@end
