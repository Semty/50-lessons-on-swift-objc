//
//  RTStudentOverallTableViewController.h
//  HW41
//
//  Created by Руслан on 01.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTStudent;

@interface RTStudentOverallTableViewController : UITableViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) RTStudent *student;

@end
