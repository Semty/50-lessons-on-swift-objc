//
//  RTRegFormViewController.m
//  HW29
//
//  Created by Руслан on 03.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTRegFormViewController.h"

@interface RTRegFormViewController ()

@end

typedef enum {
    
    RTTextFieldLogin,
    RTTextFieldPassword,
    RTTextFieldFirstName,
    RTTextFieldLastName,
    RTTextFieldAge,
    RTTextFieldPhoneNumber,
    RTTextFieldEmail
    
}RTTextField;

static NSString *kLogin = @"login";
static NSString *kPassword = @"password";
static NSString *kFirstName = @"firstName";
static NSString *kLastName = @"lastName";
static NSString *kAge = @"age";
static NSString *kPhoneNumber = @"phoneNumber";
static NSString *kEmail = @"email";
static NSString *kGender = @"gender";
static NSString *kNewsSubscription = @"newsSubscription";

@implementation RTRegFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = insets;
    
    [self loadInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - Text Fields private methods

- (BOOL) phoneNumberFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *newComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [newComponents componentsJoinedByString:@""];
    
    NSMutableString *resultString = [NSMutableString string];
    
    static const int localNumberMaxLength = 7;
    static const int areaCodeMaxLength = 3;
    static const int countryCodeMaxLength = 3;
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength) {
        return NO;
    }
    
    NSInteger localNumberLength = MIN([newString length], localNumberMaxLength);
    
    if (localNumberLength > 0) {
        
        NSString *number = [newString substringFromIndex:(int)[newString length] - localNumberLength];
        
        [resultString appendString:number];
        
        if ([resultString length] > 3) {
            [resultString insertString:@"-" atIndex:3];
        }
    }
    
    if ([newString length] > localNumberMaxLength) {
        
        NSInteger areaCodeLength = MIN((int)[newString length] - localNumberMaxLength, areaCodeMaxLength);
        
        NSRange areaCodeRange = NSMakeRange((int)[newString length] - localNumberMaxLength -
                                            areaCodeLength, areaCodeLength);
        
        NSString *area = [newString substringWithRange:areaCodeRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength -
                                          areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange((int)[newString length] - localNumberMaxLength -
                                               areaCodeMaxLength - countryCodeLength, countryCodeLength);
        
        NSString *country = [newString substringWithRange:countryCodeRange];
        
        country = [NSString stringWithFormat:@"+%@ ", country];
        
        [resultString insertString:country atIndex:0];
    }
    
    textField.text = resultString;
    
    return NO;
}

- (BOOL) ageFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (newString.integerValue > 150 || ([textField.text isEqualToString:@"0"] && ![string isEqualToString:@""])) {
        return NO;
    }
    
    return YES;
}

- (BOOL) emailFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSMutableCharacterSet *validationSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [validationSet formUnionWithCharacterSet:[NSCharacterSet characterSetWithCharactersInString:@"@_.-"]];
    
    NSArray *components = [string componentsSeparatedByCharactersInSet:[validationSet invertedSet]];
    
    if ([components count] > 1) {
        return NO;
    }
    
    if ([string isEqualToString:@"@"]) {
        
        components = [textField.text componentsSeparatedByString:@"@"];
        
        if ([components count] > 1) {
            return NO;
        }
    }
    
    if ([textField.text length] > 23 && ![string isEqualToString:@""]) {
        return NO;
    }
    
    return YES;
}

- (BOOL) nameFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger index = [self.textFieldsCollection indexOfObject:textField];
    
    [self saveInfo];
    
    switch (index) {
        case RTTextFieldFirstName:
            
            return [self nameFormWithTextField:textField range:range andString:string];
            break;
            
        case RTTextFieldLastName:
            
            return [self nameFormWithTextField:textField range:range andString:string];
            break;
            
        case RTTextFieldAge:
            
            return [self ageFormWithTextField:textField range:range andString:string];
            break;
            
        case RTTextFieldPhoneNumber:
            
            return [self phoneNumberFormWithTextField:textField range:range andString:string];
            break;
            
        case RTTextFieldEmail:
            
            return [self emailFormWithTextField:textField range:range andString:string];
            break;
            
        default:
            return YES;
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    NSUInteger currentIndex = [self.textFieldsCollection indexOfObject:textField];
    
    if (![textField isEqual:[self.textFieldsCollection lastObject]]) {
        [[self.textFieldsCollection objectAtIndex:currentIndex + 1] becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Save and Load

- (void) saveInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldLogin]).text forKey:kLogin];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldPassword]).text forKey:kPassword];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldFirstName]).text forKey:kFirstName];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldLastName]).text forKey:kLastName];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldAge]).text forKey:kAge];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldPhoneNumber]).text forKey:kPhoneNumber];
    [userDefaults setObject:((UITextField *)[self.textFieldsCollection
                                             objectAtIndex:RTTextFieldEmail]).text forKey:kEmail];
    
    [userDefaults setInteger:self.genderControl.selectedSegmentIndex forKey:kGender];
    [userDefaults setBool:self.subscriptionSwitch.on forKey:kNewsSubscription];
    
}

- (void) loadInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldLogin]).text = [userDefaults objectForKey:kLogin];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldPassword]).text = [userDefaults objectForKey:kPassword];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldFirstName]).text = [userDefaults objectForKey:kFirstName];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldLastName]).text = [userDefaults objectForKey:kLastName];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldAge]).text = [userDefaults objectForKey:kAge];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldPhoneNumber]).text = [userDefaults objectForKey:kPhoneNumber];
    ((UITextField *)[self.textFieldsCollection
                     objectAtIndex:RTTextFieldEmail]).text = [userDefaults objectForKey:kEmail];
    
    self.genderControl.selectedSegmentIndex = [userDefaults integerForKey:kGender];
    self.subscriptionSwitch.on = [userDefaults boolForKey:kNewsSubscription];
    
}

#pragma mark - Actions

- (IBAction)valueChanged:(id)sender {
    [self saveInfo];
}

@end
