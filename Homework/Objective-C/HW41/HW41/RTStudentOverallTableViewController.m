//
//  RTStudentOverallTableViewController.m
//  HW41
//
//  Created by Руслан on 01.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudentOverallTableViewController.h"
#import "RTCourseOverallTableViewController.h"
#import "RTStudent+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"

@interface RTStudentOverallTableViewController ()

@property (strong, nonatomic) NSArray *teachingCoursesArray;
@property (strong, nonatomic) NSArray *learningCoursesArray;

@end

@implementation RTStudentOverallTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.teachingCoursesArray = [self.student.teachingCourses allObjects];
    self.learningCoursesArray = [self.student.learningCourses allObjects];
    
    self.navigationItem.title = @"Person Info";
    
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
    
    if ([self.student.teachingCourses count] > 0 && [self.student.learningCourses count] > 0) {
        return 4;
    } else if ([self.student.teachingCourses count] > 0 || [self.student.learningCourses count] > 0) {
        return 3;
    } else {
        return 2;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 1;
        case 2:
            
            if ([self.student.teachingCourses count] > 0) {
                return [self.student.teachingCourses count];
            } else {
                [self.student.learningCourses count];
            }
        case 3:
            return [self.student.learningCourses count];
        default:
            return 0;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Full Name:";
        case 1:
            return @"E-Mail:";
        case 2:
            
            if ([self.student.teachingCourses count] > 0) {
                return @"Teacher in Courses:";
            } else {
                return @"Student in Courses:";
            }
        case 3:
            return @"Student in Courses:";
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *kFullName          = @"fullNameCell";
    static NSString *kEmail             = @"emailCell";
    static NSString *kLearningCourses   = @"learningCoursesCell";
    static NSString *kTeachingCourses   = @"teachingCoursesCell";
    
    UITableViewCell *cell = nil;
    RTCourse *course = nil;
    
    switch (indexPath.section) {
        case 0:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kFullName];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", self.student.firstName, self.student.lastName];
            
            return cell;
            
        case 1:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kEmail];
            cell.textLabel.text = self.student.email;
            
            return cell;
            
        case 2:
            
            if ([self.student.teachingCourses count] > 0) {
                cell = [tableView dequeueReusableCellWithIdentifier:kTeachingCourses];
                
                course = [self.teachingCoursesArray objectAtIndex:indexPath.row];
                
                cell.textLabel.text = course.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld students", [course.students count]];
                
                return cell;
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:kLearningCourses];
                
                course = [self.learningCoursesArray objectAtIndex:indexPath.row];
                
                cell.textLabel.text = course.name;
                cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld students", [course.students count]];
                
                return cell;
            }
            
        case 3:
            
            cell = [tableView dequeueReusableCellWithIdentifier:kLearningCourses];
            
            course = [self.learningCoursesArray objectAtIndex:indexPath.row];
            
            cell.textLabel.text = course.name;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld students", [course.students count]];
            
            return cell;
            
        default:
            return nil;
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 2:
            return YES;
            break;
        case 3:
            return YES;
            break;
        default:
            break;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RTCourseOverallTableViewController *vc = [self.storyboard
                                               instantiateViewControllerWithIdentifier:@"RTCourseOverallTableViewController"];
    RTCourse *course = nil;
    
    switch (indexPath.section) {
        case 2:
            
            if ([self.student.teachingCourses count] > 0) {
                course = [self.teachingCoursesArray objectAtIndex:indexPath.row];
            } else {
                course = [self.learningCoursesArray objectAtIndex:indexPath.row];
            }
            
            break;
        case 3:
            course = [self.learningCoursesArray objectAtIndex:indexPath.row];
            break;
        default:
            break;
    }
    
    vc.course = course;
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
