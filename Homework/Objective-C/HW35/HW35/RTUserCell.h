//
//  RTUserCell.h
//  HW35
//
//  Created by Руслан on 22.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTUserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullname;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;

@end
