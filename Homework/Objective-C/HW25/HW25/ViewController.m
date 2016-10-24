//
//  ViewController.m
//  HW25
//
//  Created by Руслан on 24.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableString *stringNumbers;
@property (assign, nonatomic) double operand;
@property (strong, nonatomic) NSMutableArray *numbers;
@property (assign, nonatomic) Actions actionBetweenNumbers;
@property (assign, nonatomic) Actions storageMainAction;
@property (assign, nonatomic) Actions startWithDifferentNumbers;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numbers = [[NSMutableArray alloc] init];
    self.stringNumbers = [[NSMutableString alloc] init];
    self.actionBetweenNumbers = None;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Supported orientations

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown;
}

#pragma mark - Calculator helpful functions

- (NSString *) removeAllZeroes:(double)num {
    
    NSString *string = [NSString stringWithFormat:@"%f", num];
    
    NSMutableArray *nums = [[NSMutableArray alloc] init];
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
                                [nums addObject:substring];
                            }];
    
    for (NSString *character in nums.reverseObjectEnumerator) {
        if ([character isEqualToString:@"0"] && [string length] != 1) {
            [nums removeLastObject];
        } else if ([character isEqualToString:@"."]) {
            [nums removeLastObject];
            break;
        } else {
            break;
        }
    }
    
   return [nums componentsJoinedByString:@""];
}

- (void) plusAllOperands {
    
    NSNumber *number = [NSNumber numberWithDouble:[self.stringNumbers doubleValue]];
    [self.numbers addObject:number];
    NSLog(@"Numbers: %@", self.numbers);
    self.outputLabel.text = self.stringNumbers;
    self.stringNumbers = [[NSMutableString alloc] initWithString:@""];
}

- (void) plusMinusAction {
    
    double tempNumber = [self.stringNumbers doubleValue] * (-1);
    self.stringNumbers = [NSMutableString stringWithFormat:@"%@", [self removeAllZeroes:tempNumber]];
    
    NSLog(@"PlusMinus");
    self.outputLabel.text = self.stringNumbers;
    
}

- (void) deleteAll {
    
    self.actionBetweenNumbers = None;
    self.stringNumbers = [[NSMutableString alloc] initWithString:@""];
    self.outputLabel.text = @"0";
    [self.numbers removeAllObjects];
}

- (void) erase {
    
    if ([self.stringNumbers length] > 1) {
        NSString *tempString = [self.stringNumbers substringWithRange:NSMakeRange(0, [self.stringNumbers length] - 1)];
        
        self.stringNumbers = [[NSMutableString alloc] initWithString:tempString];
        self.outputLabel.text = self.stringNumbers;
    } else if ([self.stringNumbers length] == 1) {
        self.stringNumbers = [[NSMutableString alloc] initWithString:@"0"];
        self.outputLabel.text = @"0";
    }
}

- (void) addPointToNumber {
    
    NSMutableString *tempNumber = [[NSMutableString alloc] initWithString:
                                   [self removeAllZeroes:[self.stringNumbers doubleValue]]];
    
    if (![tempNumber containsString:@"."]) {
        [tempNumber appendFormat:@"."];
    }
    
    self.stringNumbers = tempNumber;
    self.outputLabel.text = self.stringNumbers;
}

- (void) calculateResultInOutput {
    
    double operand1 = [self.numbers.firstObject doubleValue];
    double operand2 = [self.numbers.lastObject doubleValue];
    
    NSLog(@"op1: %f, op2: %f", operand1, operand2);
    
    NSString *resultString = @"";
    
    switch (self.actionBetweenNumbers) {
        case Plus:
            NSLog(@"Plus");
            self.operand = operand1 + operand2;
            resultString = [self removeAllZeroes:self.operand];
            self.outputLabel.text = resultString;
            break;
        case Multiplication:
            NSLog(@"Multiplication");
            self.operand = operand1 * operand2;
            resultString = [self removeAllZeroes:self.operand];
            self.outputLabel.text = resultString;
            break;
        case Division:
            NSLog(@"Division");
            self.operand = operand1 / operand2;
            resultString = [self removeAllZeroes:self.operand];
            self.outputLabel.text = resultString;
            break;
        case Minus:
            NSLog(@"Minus");
            self.operand = operand1 - operand2;
            resultString = [self removeAllZeroes:self.operand];
            self.outputLabel.text = resultString;
            break;
        case Modulo:
            NSLog(@"Modulo");
            self.operand = (int)operand1 % (int)operand2;
            resultString = [self removeAllZeroes:self.operand];
            self.outputLabel.text = resultString;
            break;
        default:
            break;
    }
    [self.numbers removeAllObjects];
    self.stringNumbers = [NSMutableString stringWithFormat:@"%@", [self removeAllZeroes:self.operand]];
    self.actionBetweenNumbers = None;
    self.startWithDifferentNumbers = None;
}

- (void) printNumberInOutput {
    
    if (!(self.operand == 0 && [self.outputLabel.text isEqualToString:@"0"])) {
        double number = self.operand;
        [self.stringNumbers appendString:[NSString stringWithFormat:@"%1.f", number]];
        
        NSString *stringNumber = self.stringNumbers;
        
        self.outputLabel.text = stringNumber;
    }
}

- (void) whatIsBeingPushed:(NSInteger)tag {
    
    if (tag >= 0 && tag < 10) { // buttons - (0...9)
        
        if (self.actionBetweenNumbers == None && self.startWithDifferentNumbers != None) {
            
            self.operand = tag;
            [self printNumberInOutput];
            
        } else if (self.startWithDifferentNumbers == Active) {
            
            [self plusAllOperands];
            self.operand = tag;
            [self printNumberInOutput];
            self.storageMainAction = self.actionBetweenNumbers;
            self.actionBetweenNumbers = None;
            
        } else {
            
            self.stringNumbers = [NSMutableString stringWithFormat:@""];
            self.operand = tag;
            [self printNumberInOutput];
            self.startWithDifferentNumbers = Active;
            
        }
        
    } else if (tag == 14) {                     // button - PlusMinus
        
        [self plusMinusAction];
        
    } else if (tag == 17) {                     // button - Erase
        
        [self erase];
        
    } else if (tag == 18) {                     // button - Delete
        
        [self deleteAll];
        
    } else if (tag == 19) {                     // button - Point
        
        [self addPointToNumber];
        
    } else if (tag != 16) {                     // buttons - (Plus, Minus, Multiplication, Division, Modulo)
        
        self.actionBetweenNumbers = (int)tag;
        self.startWithDifferentNumbers = Active;
        
    } else {                                    // button - Equal
        
        self.actionBetweenNumbers = self.storageMainAction;
        [self plusAllOperands];
        [self calculateResultInOutput];
        
    }
}

#pragma mark - Calculator Actions

- (IBAction)calculatorAction:(UIButton *)sender {
    
    [self whatIsBeingPushed:sender.tag];
    
}
@end
