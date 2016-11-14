//
//  RTDirectoryViewController.h
//  FileManagerTest
//
//  Created by Руслан on 13.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTDirectoryViewController : UITableViewController

@property (strong, nonatomic) NSString *path;
- (instancetype) initWithFolderPath:(NSString *)path;

- (IBAction)actionInfoCell:(id)sender;

@end
