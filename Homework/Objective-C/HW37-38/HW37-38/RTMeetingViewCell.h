//
//  RTMeetingViewCell.h
//  HW37-38
//
//  Created by Руслан on 12.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTMeetingViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *fullnameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *meetingStatus;
@property (weak, nonatomic) IBOutlet UILabel *meetingDistanceLabel;


@end
