//
//  ViewController.m
//  HW36
//
//  Created by Руслан on 28.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTDateViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate, UITextFieldDelegate>

@end

static NSString *kFirstName         = @"firstname";
static NSString *kLastName          = @"lastname";
static NSString *kGender            = @"gender";
static NSString *kDateOfBirth       = @"dateofbirth";
static NSString *kEducation         = @"education";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadInfo];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Popovers

/*
- (void) popoverInfoForIpadWith:(UIBarButtonItem *)sender {
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"informationController"];
        vc.navigationItem.leftBarButtonItem = nil;
        vc.modalPresentationStyle = UIModalPresentationPopover;
        vc.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) / 2.5,
                                             CGRectGetHeight(self.view.bounds) / 4);
        
        [self presentViewController:vc animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        popover.barButtonItem = sender;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popover.delegate = self;
    }
}

- (void) popoverDateOfBirthForIpadWith:(UITextField *)sender {
        
        UIViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"DateOfBirthViewController"];
        vc.modalPresentationStyle = UIModalPresentationPopover;
        
        [self presentViewController:vc animated:YES completion:nil];
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
        popover.delegate = self;
        
        CGRect popoverRect = [sender convertRect:sender.frame toView:self.view];
        
        popover.sourceView = self.view;
        popover.sourceRect = popoverRect;
}
*/

#pragma mark - Segues

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    
    if ([segue.identifier isEqualToString:@"showDateOfBirth"] || [segue.identifier isEqualToString:@"showInfo"]) {
        
        RTDateViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"showEducation"]) {
        
        RTEducationViewController *vc = [segue destinationViewController];
        vc.delegate = self;
        vc.popoverPresentationController.delegate = self;
    }
    
}

#pragma mark - Save and Load

- (void) saveInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.firstNameField.text forKey:kFirstName];
    [userDefaults setObject:self.lastNameField.text forKey:kLastName];
    [userDefaults setInteger:self.genderControl.selectedSegmentIndex forKey:kGender];
    [userDefaults setObject:self.dateOfBirthField.text forKey:kDateOfBirth];
    [userDefaults setObject:self.educationField.text forKey:kEducation];
    
    [userDefaults synchronize];
}

- (void) loadInfo {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.firstNameField.text = [userDefaults objectForKey:kFirstName];
    self.lastNameField.text = [userDefaults objectForKey:kLastName];
    self.dateOfBirthField.text = [userDefaults objectForKey:kDateOfBirth];
    self.genderControl.selectedSegmentIndex = [userDefaults integerForKey:kGender];
    self.educationField.text = [userDefaults objectForKey:kEducation];
    
    [userDefaults synchronize];
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
    } else if ([textField isEqual:self.educationField]) {
        
        [self performSegueWithIdentifier:@"showEducation" sender:textField];
        
        return NO;
    }
    return YES;
}

#pragma mark - Actions

- (IBAction)actionSaveInfo:(UIButton *)sender {
    
    [self saveInfo];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (IBAction)actionDeleteAll:(UIButton *)sender {
    
    self.firstNameField.text = @"";
    self.lastNameField.text = @"";
    self.genderControl.selectedSegmentIndex = 0;
    self.dateOfBirthField.text = @"";
    self.educationField.text = @"";
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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












