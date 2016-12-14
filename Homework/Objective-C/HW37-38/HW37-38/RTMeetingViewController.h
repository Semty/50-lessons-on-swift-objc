//
//  RTMeetingViewController.h
//  HW37-38
//
//  Created by Руслан on 12.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RTAmountOfStudents <NSObject>

@property (strong, nonatomic, readonly) NSMutableArray *students;

@property (strong, nonatomic, readonly) NSMutableArray *withoutCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *firstCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *secondCircleStudents;
@property (strong, nonatomic, readonly) NSMutableArray *thirdCircleStudents;

@end

@interface RTMeetingViewController : UITableViewController

@property (weak, nonatomic) id <RTAmountOfStudents> delegate;

- (IBAction)actionOKPressed:(UIButton *)sender;

@end
