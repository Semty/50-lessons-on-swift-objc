//
//  ViewController.m
//  TextFields1Test
//
//  Created by Руслан on 30.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.firstNameField.keyboardAppearance = UIKeyboardAppearanceDark;
    //self.lastNameField.keyboardAppearance = UIKeyboardAppearanceLight;
    
    //self.firstNameField.delegate = self;
    //self.lastNameField.delegate = self;
    
    [self.firstNameField becomeFirstResponder];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationTextDidBeginEditing:)
               name:UITextFieldTextDidBeginEditingNotification object:nil];
    
    [nc addObserver:self selector:@selector(notificationTextDidEndEditing:)
               name:UITextFieldTextDidEndEditingNotification object:nil];
    
    [nc addObserver:self selector:@selector(notificationTextDidChange:)
               name:UITextFieldTextDidChangeNotification object:nil];
    
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionLog:(UIButton *)sender {
    
    if ([self.firstNameField.text length] > 0 && [self.lastNameField.text length] > 0) {
        NSLog(@"%@ %@", self.firstNameField.text, self.lastNameField.text);
    }
    
    if ([self.firstNameField isFirstResponder]) {
        [self.firstNameField resignFirstResponder];
    } else if ([self.lastNameField isFirstResponder]) {
        [self.lastNameField resignFirstResponder];
    }
}

- (IBAction)actionTextChanged:(UITextField *)sender {
    
    NSLog(@"%@", sender.text);
    
}

#pragma mark - UITextFieldDelegate

/*
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return [textField isEqual:self.firstNameField] ? YES : NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return NO;
}
*/

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Notifications

- (void) notificationTextDidBeginEditing:(NSNotification *)notification {
    
    NSLog(@"notificationTextDidBeginEditing");
    
}

- (void) notificationTextDidEndEditing:(NSNotification *)notification {
    
    NSLog(@"notificationTextDidEndEditing");
    
}

- (void) notificationTextDidChange:(NSNotification *)notification {
    
    NSLog(@"notificationTextDidChange");
    
}

@end
