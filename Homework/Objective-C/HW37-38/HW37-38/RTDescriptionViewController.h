//
//  RTDescriptionVeiwController.h
//  HW37-38
//
//  Created by Руслан on 10.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTDescriptionViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressLabel;

- (IBAction)actionOKPressed:(UIButton *)sender;

@end
