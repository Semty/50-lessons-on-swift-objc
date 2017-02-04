//
//  RTCourseOverallTableViewController.m
//  HW41
//
//  Created by Руслан on 01.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourseOverallTableViewController.h"
#import "RTCourse+CoreDataClass.h"
#import "RTStudentOverallTableViewController.h"
#import "RTStudent+CoreDataClass.h"

@interface RTCourseOverallTableViewController ()

@property (strong, nonatomic) NSArray *students;

@end

@implementation RTCourseOverallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.students = [self.course.students allObjects];
    
    self.navigationItem.title = @"Course Info";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home"]
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(actionCancel:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if ([self.course.students count] > 0) {
        return 5;
    } else {
        return 4;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 1;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return [self.course.students count];
            break;
        default:
            return 0;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Name :";
            break;
        case 1:
            return @"Subject :";
            break;
        case 2:
            return @"Study Branch :";
            break;
        case 3:
            return @"Teacher :";
            break;
        case 4:
            return [NSString stringWithFormat:@"Students (%ld) :", [self.course.students count]];
            break; 
        default:
            return nil;
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kName = @"nameCell";
    static NSString *kSubject = @"subjectCell";
    static NSString *kStudyBranch = @"studyBranchCell";
    static NSString *kTeacher = @"teacherCell";
    static NSString *kStudents = @"studentsCell";
    
    UITableViewCell *cell = nil;
    RTStudent *teacher = nil;
    RTStudent *student = nil;
    
    switch (indexPath.section) {
        case 0:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kName];
            
            cell.textLabel.text = self.course.name;
            
            return cell;
            break;
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kSubject];
            
            cell.textLabel.text = self.course.subject;
            
            return cell;
            break;
        case 2:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kStudyBranch];
            
            cell.textLabel.text = self.course.studyBranch;
            
            return cell;
            break;
        case 3:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kTeacher];
            
            teacher = self.course.teacher;
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", teacher.firstName, teacher.lastName];
            
            return cell;
            break;
        case 4:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kStudents];
            
            student = [self.students objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
            
            return cell;
            break;
            
        default:
            return nil;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 1:
            return 50;
            break;
        case 2:
            return 50;
            break;
        case 4:
            return 44;
            break;
            
        default:
            break;
    }
    return 60;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 3:
            return YES;
            break;
        case 4:
            return YES;
            break;
        default:
            break;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RTStudentOverallTableViewController *vc = [self.storyboard
                                               instantiateViewControllerWithIdentifier:@"RTStudentOverallTableViewController"];
    RTStudent *student = nil;
    
    switch (indexPath.section) {
        case 3:
            student = self.course.teacher;
            break;
        case 4:
            student = [self.students objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    vc.student = student;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"imageItem";
    
    UICollectionViewCell *imageItem = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                forIndexPath:indexPath];
    return imageItem;
}

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem *)barButtonItem {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
