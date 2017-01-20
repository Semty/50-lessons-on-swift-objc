//
//  RTTableViewController.m
//  HW40
//
//  Created by Руслан on 19.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTTableViewController.h"
#import "RTDateViewController.h"
#import "RTStudent.h"

@interface RTTableViewController () <UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@end

NSString *kfirstName = @"firstName";
NSString *klastName = @"lastName";
NSString *kdateOfBirth = @"dateOfBirth";
NSString *kgender = @"gender";
NSString *kgrade = @"grade";

@implementation RTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.student = [[RTStudent alloc] init];
    
    [self.student addObserver:self
                   forKeyPath:kfirstName
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:klastName
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kdateOfBirth
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kgender
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    [self.student addObserver:self
                   forKeyPath:kgrade
                      options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
                      context:nil];
    
    /*
     
     //                                     *** MASTER && SUPERMAN ***
     
    RTStudent *student1 = [[RTStudent alloc] init];
    RTStudent *student2 = [[RTStudent alloc] init];
    RTStudent *student3 = [[RTStudent alloc] init];
    RTStudent *student4 = [[RTStudent alloc] init];
    
    student4.friend = student3;
    student3.friend = student2;
    student2.friend = student1;
    student1.friend = self.student;
    self.student.friend = student4;
    
    NSArray *students = @[ student4, student3, student2, student1, self.student ];
    
    for (RTStudent *student in students) {
        [student setValue:@"kek" forKeyPath:@"friend.lastName"];
    }
    
    NSArray *studentNames = [students valueForKeyPath:@"@distinctUnionOfObjects.firstName"];
    NSDate *minBirth = [students valueForKeyPath:@"@min.dateOfBirth"];
    NSDate *maxBirth = [students valueForKeyPath:@"@max.dateOfBirth"];
    double avgGrade = [[students valueForKeyPath:@"@avg.grade"] doubleValue];
    double sumAllGrade = [[students valueForKeyPath:@"@sum.grade"] doubleValue];
    
    
    NSLog(@"\n\nALL NAMES: %@\n\n", studentNames);
    NSLog(@"MIN BIRTH: %@\n\n", minBirth);
    NSLog(@"MAX BIRTH: %@\n\n", maxBirth);
    NSLog(@"AVG GRADE: %f\n\n", avgGrade);
    NSLog(@"SUM ALL GRADE: %f\n\n", sumAllGrade);
     
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Observing

- (void) observeValueForKeyPath:(NSString *)keyPath
                       ofObject:(id)object
                         change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                        context:(void *)context {
    
    NSLog(@"\n\nobserveValueForKeyPath: %@\nobject: %@\nchange: %@\n", keyPath, object, change);
    
}

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(UITextField *)sender {
    
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"showDateOfBirth"]) {
        
        RTDateViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        
        CGRect popoverRect = [sender convertRect:sender.frame toView:self.view];
        
        popover.sourceView = self.view;
        popover.sourceRect = popoverRect;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        [self.lastNameField becomeFirstResponder];
    } else {
        [self.lastNameField resignFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.dateOfBirthField]) {
        
        [self performSegueWithIdentifier:@"showDateOfBirth" sender:textField];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.firstNameField]) {
        self.student.firstName = textField.text;
    } else if ([textField isEqual:self.lastNameField]) {
        self.student.lastName = textField.text;
    }
    
    return YES;
}

#pragma mark - Actions

- (IBAction)actionGenderChanged:(UISegmentedControl *)sender {
    
    switch (sender.selectedSegmentIndex) {
        case RTWoman:
            self.student.gender = RTWoman;
            break;
        case RTMan:
            self.student.gender = RTMan;
            break;
        default:
            break;
    }
    
}

- (IBAction)actionGradeChanged:(UISlider *)sender {
    self.gradeLabel.text = [NSString stringWithFormat:@"%1.1f", sender.value];
    self.student.grade = sender.value;
}

- (IBAction)actionReset:(UIButton *)sender {
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.genderSegmentedControl.selectedSegmentIndex = 0;
    self.dateOfBirthField.text = @"";
    self.gradeLabel.text = @"2.5";
    self.gradeSlider.value = 2.5;
    
    [self.student resetAllProperties];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

@end





