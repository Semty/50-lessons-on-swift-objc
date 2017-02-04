//
//  RTStudyBranchesCell.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTStudyBranchesController.h"

@interface RTStudyBranchesCell : UITableViewCell <RTStudyBranchesProtocol>

@property (weak, nonatomic) IBOutlet UITextField *studyBranchesField;
@property (assign, nonatomic) NSInteger selectedRow;

@end
