//
//  ViewController.h
//  ButtonsTest
//
//  Created by Руслан on 24.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;

- (IBAction)actionTest2:(UIButton *)sender;
- (IBAction)actionTest2TouchDown:(UIButton *)sender;

@end

