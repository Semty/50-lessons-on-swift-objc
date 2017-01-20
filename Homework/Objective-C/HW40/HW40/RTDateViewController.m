//
//  RTDateViewController.m
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTDateViewController.h"
#import "RTStudent.h"

@interface RTDateViewController ()

@property (strong, nonatomic) NSDateFormatter *formatter;

@end

@implementation RTDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMMM, yyyy"];
    self.formatter = formatter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (IBAction)actionDateChanged:(UIDatePicker *)sender {
    
    NSString *stringDate = [self.formatter stringFromDate:sender.date];
    self.delegate.dateOfBirthField.text = stringDate;
    self.delegate.student.dateOfBirth = sender.date;
}

- (IBAction)actionDonePressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end







