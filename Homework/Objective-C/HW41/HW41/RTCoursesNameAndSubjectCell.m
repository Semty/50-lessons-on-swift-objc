//
//  RTCoursesNameAndSubjectCell.m
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCoursesNameAndSubjectCell.h"

@interface RTCoursesNameAndSubjectCell () <UITextFieldDelegate>

@end

@implementation RTCoursesNameAndSubjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Validation

- (BOOL) nameFormWithTextField:(UITextField *)textField range:(NSRange)range andString:(NSString *)string {
    
    NSMutableCharacterSet *mutCharSet = [NSMutableCharacterSet letterCharacterSet];
    [mutCharSet addCharactersInString:@" "];
    [mutCharSet invert];

    NSArray *components = [string componentsSeparatedByCharactersInSet:mutCharSet];
    
    if ([components count] > 1) {
        return NO;
    }
    
    if (textField == self.nameField && self.nameIsOk != YES) {
        self.nameIsOkImage.image = [UIImage imageNamed:@"checked"];
        self.nameIsOk = YES;
        
    } else if (textField == self.subjectField && self.subjectIsOk != YES) {
        self.subjectIsOkImage.image = [UIImage imageNamed:@"checked"];
        self.subjectIsOk = YES;
    }
    
    return YES;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField == self.nameField || textField == self.subjectField) {
        
        if (textField == self.nameField && range.location == 0 && [string isEqualToString:@""]) {
            self.nameIsOk = NO;
            self.nameIsOkImage.image = [UIImage imageNamed:@"cancel"];
            return YES;
        } else if (textField == self.subjectField && range.location == 0 && [string isEqualToString:@""]) {
            self.subjectIsOk = NO;
            self.subjectIsOkImage.image = [UIImage imageNamed:@"cancel"];
            return YES;
        }
        
        return [self nameFormWithTextField:textField range:range andString:string];
        
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.nameField resignFirstResponder];
    [self.subjectField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    if (textField == self.nameField) {
        
        self.nameIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.nameIsOk = NO;
        
    } else if (textField == self.subjectField) {
        
        self.subjectIsOkImage.image = [UIImage imageNamed:@"cancel"];
        self.subjectIsOk = NO;
        
    }
    
    return YES;
}


@end

















