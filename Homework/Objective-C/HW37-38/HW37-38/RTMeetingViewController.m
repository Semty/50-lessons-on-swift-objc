//
//  RTMeetingViewController.m
//  HW37-38
//
//  Created by Руслан on 12.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTMeetingViewController.h"
#import "RTMeetingViewCell.h"
#import "RTStudent.h"

@interface RTMeetingViewController ()

@end

@implementation RTMeetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [NSString stringWithFormat:@"0 - 2 km, %ld person(s)", [self.delegate.firstCircleStudents count]];
    } else if (section == 1) {
        return [NSString stringWithFormat:@"2 - 5 km, %ld person(s)", [self.delegate.secondCircleStudents count]];
    } else if (section == 2) {
        return [NSString stringWithFormat:@"5 - 8.5 km, %ld person(s)", [self.delegate.thirdCircleStudents count]];
    } else {
        return [NSString stringWithFormat:@"8.5 - ... km, %ld person(s)", [self.delegate.withoutCircleStudents count]];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [self.delegate.firstCircleStudents count];
    } else if (section == 1) {
        return [self.delegate.secondCircleStudents count];
    } else if (section == 2) {
        return [self.delegate.thirdCircleStudents count];
    } else {
        return [self.delegate.withoutCircleStudents count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"identifier";
    
    RTMeetingViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:identifier];
    
    RTStudent *student;
    
    if (indexPath.section == 0) {
        student = [self.delegate.firstCircleStudents objectAtIndex:indexPath.row];
    } else if (indexPath.section == 1) {
        student = [self.delegate.secondCircleStudents objectAtIndex:indexPath.row];
    } else if (indexPath.section == 2) {
        student = [self.delegate.thirdCircleStudents objectAtIndex:indexPath.row];
    } else {
        student = [self.delegate.withoutCircleStudents objectAtIndex:indexPath.row];
    }
    
    cell.fullnameLabel.text = [NSString stringWithFormat:@"%@ %@", student.name, student.surname];
    cell.meetingDistanceLabel.text = student.meetingDistance;
    
    if (student.meetingState) {
        cell.meetingStatus.image = [UIImage imageNamed:@"checked"];
    } else {
        cell.meetingStatus.image = [UIImage imageNamed:@"cancel"];
    }
    
    return cell;
}

- (IBAction)actionOKPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
