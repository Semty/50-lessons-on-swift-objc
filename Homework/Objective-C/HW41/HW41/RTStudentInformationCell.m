//
//  RTStudentInformationCell.m
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudentInformationCell.h"

@interface RTStudentInformationCell () <UITextFieldDelegate>

@end

typedef enum {
    
    RTTextFieldFirstName,
    RTTextFieldLastName,
    RTTextFieldEmail
    
} RTTextField;

@implementation RTStudentInformationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Validation

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
        self.emailIsOkImage.image = [UIImage imageNamed:@"checked"];
        self.emailIsOk = YES;
    }
    
    if ([string isEqualToString:@""] && ([[textField.text substringWithRange:range] isEqualToString:@"@"] || range.location == 0)) {
        self.emailIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.emailIsOk = NO;
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
    
    if (textField == self.firstNameField && self.firstNameIsOk != YES) {
        self.firstNameIsOkImage.image = [UIImage imageNamed:@"checked"];
        self.firstNameIsOk = YES;
        
    } else if (textField == self.lastNameField && self.lastNameIsOk != YES) {
        self.lastNameIsOkImage.image = [UIImage imageNamed:@"checked"];
        self.lastNameIsOk = YES;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.firstNameField || textField == self.lastNameField) {
        
        if (textField == self.firstNameField && range.location == 0 && [string isEqualToString:@""]) {
            self.firstNameIsOk = NO;
            self.firstNameIsOkImage.image = [UIImage imageNamed:@"cancel"];
            return YES;
        } else if (textField == self.lastNameField && range.location == 0 && [string isEqualToString:@""]) {
            self.lastNameIsOk = NO;
            self.lastNameIsOkImage.image = [UIImage imageNamed:@"cancel"];
            return YES;
        }
        
        return [self nameFormWithTextField:textField range:range andString:string];
        
    } else if (textField == self.emailField) {
        
        return [self emailFormWithTextField:textField range:range andString:string];
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.emailField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (textField == self.firstNameField) {
        
        self.firstNameIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.firstNameIsOk = NO;
        
    } else if (textField == self.lastNameField) {
      
        self.lastNameIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.lastNameIsOk = NO;
        
    } else if (textField == self.emailField) {
        
        self.emailIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.emailIsOk = NO;
    }
    
    return YES;
}

@end
