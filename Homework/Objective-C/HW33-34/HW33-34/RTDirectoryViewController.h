//
//  RTDirectoryViewController.h
//  HW33-34
//
//  Created by Руслан on 15.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTDirectoryViewController : UITableViewController

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSArray *contents;

- (instancetype) initWithPath:(NSString *)path;

@end
