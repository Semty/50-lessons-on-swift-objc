//
//  ViewController.h
//  HW30
//
//  Created by Руслан on 05.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RTRandomColor;
@class RTStudent;

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

