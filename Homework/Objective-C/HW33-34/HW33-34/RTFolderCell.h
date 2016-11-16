//
//  RTFolderCell.h
//  HW33-34
//
//  Created by Руслан on 15.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTFolderCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *folderSizeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *folderImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
