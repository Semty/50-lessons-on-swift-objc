//
//  RTPersonCell.h
//  HW41
//
//  Created by Руслан on 25.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPersonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *personImage;
@property (weak, nonatomic) IBOutlet UILabel *personFullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *personEmalLabel;

@end
