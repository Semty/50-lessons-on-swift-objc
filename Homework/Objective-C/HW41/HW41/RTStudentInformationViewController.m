//
//  RTStudentInformationViewController.m
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudentInformationViewController.h"
#import "RTPersonCell.h"
#import "RTStudentImageCell.h"
#import "RTStudent+CoreDataClass.h"
#import "RTStudentInformationCell.h"
#import "RTStudentsTableViewController.h"

@interface RTStudentInformationViewController ()

@end

typedef enum {
    
    RTSectionImage,
    RTSectionInfo
    
} RTSection;

typedef enum {
    
    RTRowFirstName,
    RTRowLastName,
    RTRowEmail
    
} RTRow;

static NSString *kNewStudent = @"New Student";
static NSString *kEditStudent = @"Edit Info";

@implementation RTStudentInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = self.titleName;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == RTSectionImage) {
        return NO;
    }
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == RTSectionImage) {
        return 175;
    }
    
    return 45;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == RTSectionImage) {
        return 1;
    } else if (section == RTSectionInfo) {
        return 3;
    } else {
        return 0;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == RTSectionImage && [self.titleName isEqualToString:kNewStudent]) {
        
        return @"Please, Enter Student's First Name,\nLast Name and E-Mail Address";
        
    } else if (section == RTSectionImage && [self.titleName isEqualToString:kEditStudent]) {
        
        return @"You can Edit Student's Information Here";
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *imageCell      = @"imageCell";
    static NSString *firstNameCell  = @"firstNameCell";
    static NSString *lastNameCell   = @"lastNameCell";
    static NSString *emailCell      = @"emailCell";
    
    RTStudentImageCell *cell = nil;
    
    RTStudentInformationCell *informationCell = nil;
    
    if (indexPath.section == RTSectionImage) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:imageCell forIndexPath:indexPath];
        cell.studentImage.image = [UIImage imageNamed:@"student.png"];
        
        if (self.editCell) {
            cell.studentImage.image = [UIImage imageNamed:@"editStudent"];
        }
        
        return cell;
        
    } else if (indexPath.section == RTSectionInfo) {
        
        switch (indexPath.row) {
                
            case RTRowFirstName:
                
                informationCell = [tableView dequeueReusableCellWithIdentifier:firstNameCell
                                                                  forIndexPath:indexPath];
                self.studentfirstName = informationCell;
                
                if (self.editCell) {
                    self.studentfirstName.firstNameField.text = [[self.editCell.personFullNameLabel.text
                                                                  componentsSeparatedByString:@" "] objectAtIndex:0];
                    self.studentfirstName.firstNameIsOk = YES;
                    self.studentfirstName.firstNameIsOkImage.image = [UIImage imageNamed:@"checked"];
                }
                
                return informationCell;
                
            case RTRowLastName:
                
                informationCell = [tableView dequeueReusableCellWithIdentifier:lastNameCell
                                                                  forIndexPath:indexPath];
                self.studentLastName = informationCell;
                
                if (self.editCell) {
                    self.studentLastName.lastNameField.text = [[self.editCell.personFullNameLabel.text
                                                                componentsSeparatedByString:@" "] objectAtIndex:1];
                    self.studentLastName.lastNameIsOk = YES;
                    self.studentLastName.lastNameIsOkImage.image = [UIImage imageNamed:@"checked"];
                }
                
                return informationCell;
                
            case RTRowEmail:
                
                informationCell = [tableView dequeueReusableCellWithIdentifier:emailCell
                                                                  forIndexPath:indexPath];
                self.studentEmail = informationCell;
                
                if (self.editCell) {
                    self.studentEmail.emailField.text = self.editCell.personEmalLabel.text;
                    self.studentEmail.emailIsOk = YES;
                    self.studentEmail.emailIsOkImage.image = [UIImage imageNamed:@"checked"];
                }
                
                return informationCell;
                
            default:
                break;
        }
    }
    
    return cell;
}

#pragma mark - Validation

- (BOOL) infoValidation {
    
    if (!self.studentfirstName.firstNameIsOk ||
        !self.studentLastName.lastNameIsOk ||
        !self.studentEmail.emailIsOk) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:@"Student's Info is not Corrected"
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
}

#pragma mark - Actions

- (IBAction)actionSaveData:(UIBarButtonItem *)sender {
    
    if ([self.titleName isEqualToString:kNewStudent]) {
        
        if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            RTStudentsTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            RTStudent *student = [[RTStudent alloc] initWithContext:context];
            
            // If appropriate, configure the new managed object.
            student.firstName = self.studentfirstName.firstNameField.text;
            student.lastName = self.studentLastName.lastNameField.text;
            student.email = self.studentEmail.emailField.text;
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if ([self.titleName isEqualToString:kEditStudent]) {
        
        if ([self infoValidation]) {
            
            UINavigationController *nav = self.navigationController;
            RTStudentsTableViewController *vc = [[nav viewControllers] firstObject];
            
            NSManagedObjectContext *context = [vc.fetchedResultsController managedObjectContext];
            
            NSIndexPath *indexPath = [vc.tableView indexPathForCell:(UITableViewCell *)self.editCell];
            RTStudent *student = [vc.fetchedResultsController objectAtIndexPath:indexPath];
            
            // If appropriate, configure the new managed object.
            student.firstName = self.studentfirstName.firstNameField.text;
            student.lastName = self.studentLastName.lastNameField.text;
            student.email = self.studentEmail.emailField.text;
            
            // Save the context.
            NSError *error = nil;
            if (![context save:&error]) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                abort();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    }
    
    
}

@end









