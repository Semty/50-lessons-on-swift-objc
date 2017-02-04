//
//  RTLearningStudentCell.m
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTLearningStudentCell.h"

@implementation RTLearningStudentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void) makeColorAndAccessory {
    
    if (!self.isSelected) {
        
        self.isSelected = YES;
        
        self.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UIView * selectedBackgroundView = [[UIView alloc] init];
        [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:0.8f green:1.f blue:0.5f alpha:0.75f]]; // set color here
        [self setBackgroundView:selectedBackgroundView];
        
    } else {
        
        self.isSelected = NO;
        
        self.accessoryType = UITableViewCellAccessoryNone;
        
        UIView * selectedBackgroundView = [[UIView alloc] init];
        [selectedBackgroundView setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.75f]]; // set color here
        [self setBackgroundView:selectedBackgroundView];
    }
    
}

@end






