//
//  RTStudyBranchesController.m
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudyBranchesController.h"

@interface RTStudyBranchesController ()

@end

static NSString *studyBranchesString[] = {  @"Computer Science", @"Chemistry", @"Physics", @"Earth sciences",
                                            @"Space science", @"Biology", @"Social Science",
                                            @"Engineering", @"Healthcare", @"Philosophy", @"History",
                                            @"Formal Science", @"Interdisciplinary Science"                 };

@implementation RTStudyBranchesController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.delegate.selectedRow) {
        [self.studyBranchesPicker selectRow:self.delegate.selectedRow inComponent:0 animated:YES];
    }
    
    if ([self.delegate.studyBranchesField.text length] == 0) {
        self.delegate.studyBranchesField.text = [self pickerView:self.studyBranchesPicker titleForRow:0 forComponent:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return sizeof(studyBranchesString) / sizeof(NSString *);
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return studyBranchesString[row];
    
    return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.delegate.studyBranchesField.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    self.delegate.selectedRow = row;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end







