//
//  RTSettingsTableViewController.m
//  UITableViewStaticCellsTest
//
//  Created by Руслан on 02.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTSettingsTableViewController.h"

@interface RTSettingsTableViewController ()

@end

static NSString *kSettingsLogin           = @"login";
static NSString *kSettingsPassword        = @"password";
static NSString *kSettingsLevel           = @"level";
static NSString *kSettingsDetalization    = @"detalization";
static NSString *kSettingsShadows         = @"shadows";
static NSString *kSettingsSound           = @"sound";
static NSString *kSettingsMusic           = @"music";

@implementation RTSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadSettings];
    
    UIEdgeInsets inset = UIEdgeInsetsMake(20, 0, 0, 0);
    self.tableView.contentInset = inset;
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillShow:)
               name:UIKeyboardWillShowNotification object:nil];
    
    [nc addObserver:self selector:@selector(notificationKeyboardWillHide:)
               name:UIKeyboardWillHideNotification object:nil];
}

- (void) dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Save and Load

- (void) saveSettings {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:self.loginField.text    forKey:kSettingsLogin];
    [userDefaults setObject:self.passwordField.text forKey:kSettingsPassword];
    
    [userDefaults setInteger:self.levelControl.selectedSegmentIndex        forKey:kSettingsLevel];
    [userDefaults setInteger:self.detalizationControl.selectedSegmentIndex forKey:kSettingsDetalization];
    
    [userDefaults setBool:self.shadowsSwitch.isOn forKey:kSettingsShadows];
    
    [userDefaults setFloat:self.soundSlider.value forKey:kSettingsSound];
    [userDefaults setFloat:self.musicSlider.value forKey:kSettingsMusic];
    
    [userDefaults synchronize];
}

- (void) loadSettings {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    self.loginField.text    = [userDefaults objectForKey:kSettingsLogin];
    self.passwordField.text = [userDefaults objectForKey:kSettingsPassword];
    
    self.levelControl.selectedSegmentIndex          = [userDefaults integerForKey:kSettingsLevel];
    self.detalizationControl.selectedSegmentIndex   = [userDefaults integerForKey:kSettingsDetalization];
    
    self.shadowsSwitch.on = [userDefaults boolForKey:kSettingsShadows];
    
    self.soundSlider.value = [userDefaults floatForKey:kSettingsSound];
    self.musicSlider.value = [userDefaults floatForKey:kSettingsMusic];
    
}

#pragma mark - Actions

- (IBAction)actionTextChanged:(UITextField *)sender {
    
    [self saveSettings];
    
}

- (IBAction)actionValueChanged:(id)sender {
    
    [self saveSettings];
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if ([textField isEqual:self.loginField]) {
        [self.passwordField becomeFirstResponder];
    } else {
        [textField resignFirstResponder];
    }
    
    return YES;
}

#pragma mark - Notifications

- (void) notificationKeyboardWillShow:(NSNotification *)notification {
    
    NSLog(@"notificationKeyboardWillShow:\n%@", notification.userInfo);
    
}

- (void) notificationKeyboardWillHide:(NSNotification *)notification {
    
    NSLog(@"notificationKeyboardWillHide:\n%@", notification.userInfo);
    
}

@end
