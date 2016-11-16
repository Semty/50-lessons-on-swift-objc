//
//  RTNewFolderViewController.h
//  HW33-34
//
//  Created by Руслан on 15.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTNewFolderViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSString *folderName;

- (IBAction)actionTextField:(UITextField *)sender;
- (IBAction)actionCreateFolder:(UIButton *)sender;

@end
