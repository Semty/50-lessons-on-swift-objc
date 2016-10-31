//
//  ViewController.h
//  HW27-28
//
//  Created by Руслан on 31.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFieldsCollection;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *smallLabelsCollection;

@end

