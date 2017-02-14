//
//  RTPostCell.h
//  VKAPITest
//
//  Created by Руслан on 14.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *postTextLabel;

+ (CGFloat) heightForText:(NSString *)text;

@end
