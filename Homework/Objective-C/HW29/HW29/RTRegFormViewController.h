//
//  RTRegFormViewController.h
//  HW29
//
//  Created by Руслан on 03.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTRegFormViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsCollection;
@property (weak, nonatomic) IBOutlet UISegmentedControl *genderControl;
@property (weak, nonatomic) IBOutlet UISwitch *subscriptionSwitch;

- (IBAction)valueChanged:(id)sender;

@end
