//
//  RTCourseInformatonViewController.m
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCourseInformatonViewController.h"
#import "RTCoursesTableViewController.h"
#import "RTCoursesNameAndSubjectCell.h"
#import "RTStudyBranchesController.h"
#import "RTTeacherViewController.h"
#import "RTStudyBranchesCell.h"
#import "RTTeacherCell.h"
#import "RTCourseCell.h"
#import "RTCourse+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"
#import "RTDataManager.h"
#import "RTLearningStudentCell.h"
#import "RTStudent+CoreDataClass.h"

@interface RTCourseInformatonViewController () <UICollectionViewDelegate,
                                                UICollectionViewDataSource,
                                                UIPopoverPresentationControllerDelegate,
                                                UITextFieldDelegate>

@property (strong, nonatomic) NSArray *studentsArray;
@property (strong, nonatomic) NSMutableSet *selectedStudentsSet;

@end

@implementation RTCourseInformatonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = self.titleName;
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.allowsMultipleSelection = YES;
    
    self.studentsArray = [[[[RTDataManager sharedManager] persistentContainer] viewContext]
                              executeFetchRequest:[RTStudent fetchRequest] error:nil];
    
    self.studentCells = [[NSMutableArray alloc] init];
    self.selectedStudentsSet = [[NSMutableSet alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return [self.studentsArray count];
            break;
        default:
            break;
    }
    
    return 0;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        if (self.editCourse) {
            return @"Edit Initial Information";
        }
        
        return @"Initial Information";
        
    } else if (section == 1) {
        
        if (self.editCourse) {
            return @"Edit Teacher of the Course";
        }
        
        return @"Choose Teacher of the Course";
        
    } else if (section == 2) {
        
        if (self.editCourse) {
            return @"Edit Students That Will be\nLearning This Course";
        }
        
        return @"Choose Students That Will be\nLearning This Course";
    }
    
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *nameCell           = @"nameCell";
    static NSString *subjectCell        = @"subjectCell";
    static NSString *studyBranchCell    = @"studyBranchCell";
    static NSString *teacherCell        = @"teacherCell";
    static NSString *studentCell        = @"studentCell";
    
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:nameCell];
                self.nameCell = (RTCoursesNameAndSubjectCell *)cell;
                
                if (self.editCourse) {
                    self.nameCell.nameField.text = self.editCourse.name;
                    self.nameCell.nameIsOkImage.image = [UIImage imageNamed:@"checked"];
                    self.nameCell.nameIsOk = YES;
                }
                
                return cell;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:subjectCell];
                self.subjectCell = (RTCoursesNameAndSubjectCell *)cell;
                
                if (self.editCourse) {
                    self.subjectCell.subjectField.text = self.editCourse.subject;
                    self.subjectCell.subjectIsOkImage.image = [UIImage imageNamed:@"checked"];
                    self.subjectCell.subjectIsOk = YES;
                }
                
                return cell;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:studyBranchCell];
                self.studyBranchesCell = (RTStudyBranchesCell *)cell;
                
                if (self.editCourse) {
                    self.studyBranchesCell.studyBranchesField.text = self.editCourse.studyBranch;
                }
                
                return cell;
            default:
                break;
        }
        
    } else if (indexPath.section == 1) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:teacherCell];
        self.teacherCell = (RTTeacherCell *)cell;
        
        if (self.editCourse) {
            self.teacherCell.teacherField.text = self.editCell.teacherLabel.text;
            self.teacherCell.teacher = self.editCourse.teacher;
        }
        
        return cell;
        
    } else if (indexPath.section == 2) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:studentCell];
        
        RTLearningStudentCell *studentCell = (RTLearningStudentCell *)cell;
            
        RTStudent *student = [self.studentsArray objectAtIndex:indexPath.row];
            
        studentCell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        
        if (self.editCourse) {
            
            if ([self.editCourse.students containsObject:student]) {
                
                [studentCell makeColorAndAccessory];
                studentCell.isEdit = YES;
                [self.selectedStudentsSet addObject:student];
            }
            
        }
        
        [self.studentCells addObject:studentCell];
        
        return studentCell;
    }
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.section == 1) {
        return NO;
    }
    
    if (indexPath.section == 2) {
        
        RTLearningStudentCell *studentCell = [self.studentCells objectAtIndex:indexPath.row];
        
        if ([studentCell.fullNameLabel.text isEqualToString:self.teacherCell.teacherField.text]) {
            
            if (studentCell.isSelected) {
                studentCell.isEdit = NO;
                [studentCell makeColorAndAccessory];
                [self.selectedStudentsSet removeObject:[self.studentsArray objectAtIndex:indexPath.row]];
                return NO;
            }
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                           message:@"Teacher and Student Cannot be one Person"
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
            [alert addAction:actionOk];
            [self.navigationController presentViewController:alert
                                                    animated:YES
                                                  completion:nil];
            return NO;
        }
        
        // For selected students during editing (I dont know why it's so, but it does work)
        
        if (self.editCourse && studentCell.isEdit) {
            studentCell.isEdit = NO;
            [studentCell makeColorAndAccessory];
            [self.selectedStudentsSet removeObject:[self.studentsArray objectAtIndex:indexPath.row]];
            return NO;
        }
        
    }
    
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        RTLearningStudentCell *studentCell = [self.studentCells objectAtIndex:indexPath.row];
        [self.selectedStudentsSet addObject:[self.studentsArray objectAtIndex:indexPath.row]];
        
        [studentCell makeColorAndAccessory];
    }
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        
        RTLearningStudentCell *studentCell = [self.studentCells objectAtIndex:indexPath.row];
        [self.selectedStudentsSet removeObject:[self.studentsArray objectAtIndex:indexPath.row]];
        
        [studentCell makeColorAndAccessory];
    }
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

#pragma mark - UIPopoverPresentationControllerDelegate

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller traitCollection:(UITraitCollection *)traitCollection {
    return UIModalPresentationNone;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([textField isEqual:self.studyBranchesCell.studyBranchesField]) {
        
        [self performSegueWithIdentifier:@"showStudyBranches" sender:textField];
        
        return NO;
    }
    
    if ([textField isEqual:self.teacherCell.teacherField]) {
        
        [self performSegueWithIdentifier:@"showTeachers" sender:textField];
        
        return NO;
    }
    
    return YES;
}

#pragma mark - Validation

- (BOOL) infoValidation {
    
    if ([self.selectedStudentsSet containsObject:self.teacherCell.teacher]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                       message:@"Teacher and Student Cannot be one Person"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alert addAction:actionOk];
        [self.navigationController presentViewController:alert
                                                animated:YES
                                              completion:nil];
        return NO;
    }
    
    if (!self.nameCell.nameIsOk ||
        !self.subjectCell.subjectIsOk ||
        [self.studyBranchesCell.studyBranchesField.text length] < 1 ||
        !self.teacherCell.teacher) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Course Info is not Corrected"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alert addAction:actionOk];
        [self.navigationController presentViewController:alert
                                                animated:YES
                                              completion:nil];
        
        return NO;
    }
    
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.nameCell.nameField resignFirstResponder];
    [self.subjectCell.subjectField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"showStudyBranches"]) {
        
        RTStudyBranchesController *vc = [segue destinationViewController];
        vc.delegate = self.studyBranchesCell;
        vc.popoverPresentationController.delegate = self;
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        
        CGRect popoverRect = [sender convertRect:((UITextField *)sender).frame toView:self.tableView];
        
        popover.sourceView = self.tableView;
        popover.sourceRect = popoverRect;
    }
    
    if ([segue.identifier isEqualToString:@"showTeachers"]) {
        
        RTTeacherViewController *vc = [segue destinationViewController];
        vc.delegate = self.teacherCell;
        vc.popoverPresentationController.delegate = self;
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        
        CGRect popoverRect = [sender convertRect:((UITextField *)sender).frame toView:self.tableView];
        
        popover.sourceView = self.tableView;
        popover.sourceRect = popoverRect;
    }
    
}

#pragma mark - Actions

- (IBAction)actionSaveData:(UIBarButtonItem *)sender {
    
    if ([self.titleName isEqualToString:@"New Course"]) {
        
        if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            RTCoursesTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            RTCourse *course = [[RTCourse alloc] initWithContext:context];
            
            // If appropriate, configure the new managed object.
            course.name = self.nameCell.nameField.text;
            course.subject = self.subjectCell.subjectField.text;
            course.studyBranch = self.studyBranchesCell.studyBranchesField.text;
            course.teacher = self.teacherCell.teacher;
            
            [course addStudents:self.selectedStudentsSet];
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                NSLog(@"%@", [error localizedDescription]);
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if ([self.titleName isEqualToString:@"Edit Info"]) {
        
        if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            RTCoursesTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            
            NSIndexPath *indexPath = [vc.tableView indexPathForCell:(UITableViewCell *)self.editCell];
            RTCourse *course = [vc.fetchedResultsController objectAtIndexPath:indexPath];
            
            // If appropriate, configure the new managed object.
            course.name = self.nameCell.nameField.text;
            course.subject = self.subjectCell.subjectField.text;
            course.studyBranch = self.studyBranchesCell.studyBranchesField.text;
            course.teacher = self.teacherCell.teacher;
            
            [course removeStudents:course.students];
            [course addStudents:self.selectedStudentsSet];
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog(@"Edit Info Controller Save Data Error: %@, User Info: %@", error.localizedDescription, error.userInfo);
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
}

@end












