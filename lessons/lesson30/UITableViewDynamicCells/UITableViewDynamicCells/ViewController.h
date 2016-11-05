//
//  ViewController.h
//  UITableViewDynamicCells
//
//  Created by Руслан on 04.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

