//
//  RTEducationViewController.h
//  HW36
//
//  Created by Руслан on 03.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EducationControllerDelegate <NSObject>

@property (weak, nonatomic) IBOutlet UITextField *educationField;

@end

@interface RTEducationViewController : UITableViewController

@property (weak, nonatomic) id <EducationControllerDelegate> delegate;

@end
