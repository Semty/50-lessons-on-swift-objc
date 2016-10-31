//
//  ViewController.m
//  HW27-28
//
//  Created by Руслан on 31.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

typedef enum {
    
    RTTextFieldFirstName    = 0,
    RTTextFieldLastName     = 1,
    RTTextFieldAge          = 4,
    RTTextFieldPhoneNumber  = 5,
    RTTextFieldEmail        = 6
    
}RTTextField;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

#pragma mark - Text Fields private methods

- (void) copyTextToSmallLabelWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    UILabel *smallLabel = [self.smallLabelsCollection
                           objectAtIndex:[self.textFieldsCollection indexOfObject:textField]];
    
    smallLabel.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
}

- (BOOL) phoneNumberFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSArray *newComponents = [newString componentsSeparatedByCharactersInSet:validationSet];
    newString = [newComponents componentsJoinedByString:@""];
    
    NSLog(@"new string = %@", newString);
    
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
    
    NSLog(@"resultString = %@", resultString);
    
    textField.text = resultString;
    
    UILabel *smallLabel = [self.smallLabelsCollection
                           objectAtIndex:[self.textFieldsCollection indexOfObject:textField]];
    
    smallLabel.text = resultString;
    
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
    
    [self copyTextToSmallLabelWithTextField:textField range:range andString:string];
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
    
    [self copyTextToSmallLabelWithTextField:textField range:range andString:string];
    
    return YES;
}

- (BOOL) nameFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSCharacterSet *validationSet = [[NSCharacterSet letterCharacterSet] invertedSet];
    NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    [self copyTextToSmallLabelWithTextField:textField range:range andString:string];
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSInteger index = [self.textFieldsCollection indexOfObject:textField];
    
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
            
            [self copyTextToSmallLabelWithTextField:textField range:range andString:string];
            return YES;
            break;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    UILabel *smallLabel = [self.smallLabelsCollection
                           objectAtIndex:[self.textFieldsCollection indexOfObject:textField]];
    
    smallLabel.text = @"";
    
    return YES;
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

@end
