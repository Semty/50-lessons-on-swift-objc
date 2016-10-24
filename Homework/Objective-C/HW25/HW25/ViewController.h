//
//  ViewController.h
//  HW25
//
//  Created by Руслан on 24.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    Plus = 10,
    Minus, Multiplication,
    Division, PlusMinus, Modulo,
    Equal, Erase, Delete, numPoint,
    None, Active
    
} Actions;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *outputLabel;

- (IBAction)calculatorAction:(UIButton *)sender;

@end

