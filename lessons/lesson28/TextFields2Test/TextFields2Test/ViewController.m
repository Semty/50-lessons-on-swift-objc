//
//  ViewController.m
//  TextFields2Test
//
//  Created by Руслан on 31.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    /*
    NSLog(@"textField text = %@", textField.text);
    NSLog(@"shouldChangeCharactersInRange %@", NSStringFromRange(range));
    NSLog(@"replacementString = %@", string);
    */
    
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
        
        NSRange areaCodeRange = NSMakeRange((int)[newString length] - localNumberMaxLength - areaCodeLength, areaCodeLength);
        
        NSString *area = [newString substringWithRange:areaCodeRange];
        
        area = [NSString stringWithFormat:@"(%@) ", area];
        
        [resultString insertString:area atIndex:0];
    }
    
    if ([newString length] > localNumberMaxLength + areaCodeMaxLength) {
        
        NSInteger countryCodeLength = MIN((int)[newString length] - localNumberMaxLength - areaCodeMaxLength, countryCodeMaxLength);
        
        NSRange countryCodeRange = NSMakeRange((int)[newString length] - localNumberMaxLength -
                                               areaCodeMaxLength - countryCodeLength, countryCodeLength);
        
        NSString *country = [newString substringWithRange:countryCodeRange];
        
        country = [NSString stringWithFormat:@"+%@ ", country];
        
        [resultString insertString:country atIndex:0];
    }

    NSLog(@"resultString = %@", resultString);
    
    textField.text = resultString;

    return NO;
    
    /*
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@" ,.!?/@#&*"];
    NSArray *words = [resultString componentsSeparatedByCharactersInSet:set];
    NSLog(@"words = %@", words);
     return [newString length] <= 10;
    */
    
}

//- (BOOL)textFieldShouldReturn:(UITextField *)textField;              // called when 'return' key pressed. return NO to ignore.


@end
