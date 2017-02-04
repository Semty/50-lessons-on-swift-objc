//
//  RTLearningStudentCell.h
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTLearningStudentCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (assign, nonatomic) BOOL isSelected;
@property (assign, nonatomic) BOOL isEdit;

- (void) makeColorAndAccessory;

@end
