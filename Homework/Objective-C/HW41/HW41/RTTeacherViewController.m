//
//  RTTeacherViewController.m
//  HW41
//
//  Created by Руслан on 29.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTTeacherViewController.h"
#import "RTDataManager.h"
#import "RTStudent+CoreDataClass.h"

@interface RTTeacherViewController ()

@property (strong, nonatomic) NSArray *students;

@end

@implementation RTTeacherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.students = [[[[RTDataManager sharedManager] persistentContainer] viewContext]
                     executeFetchRequest:[RTStudent fetchRequest] error:nil];
    
    if (self.delegate.selectedRow) {
        [self.teacherPicker selectRow:self.delegate.selectedRow inComponent:0 animated:YES];
    }
    
    if (!self.delegate.teacher) {
        self.delegate.teacherField.text = [self pickerView:self.teacherPicker titleForRow:0 forComponent:0];
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
    return [self.students count];
}

#pragma mark - UIPickerViewDelegate

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    RTStudent *student = [self.students objectAtIndex:row];
    
    return [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    RTStudent *student = [self.students objectAtIndex:row];
    
    self.delegate.teacherField.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    self.delegate.teacher = student;
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









