//
//  RTNewFolderViewController.m
//  HW33-34
//
//  Created by Руслан on 15.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTNewFolderViewController.h"
#import "RTDirectoryViewController.h"

@interface RTNewFolderViewController () 

@end

@implementation RTNewFolderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
}

#pragma mark - Actions

- (IBAction)actionTextField:(UITextField *)sender {
    
    self.folderName = sender.text;
}

- (IBAction)actionCreateFolder:(UIButton *)sender {
    
    NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
    
    RTDirectoryViewController *vc = [self.navigationController.viewControllers objectAtIndex:index - 1];
    
    NSError *createDirectoryError = nil;
    NSString *filePath = [vc.path stringByAppendingPathComponent:self.folderName];
    
    [[NSFileManager defaultManager] createDirectoryAtPath:filePath
                              withIntermediateDirectories:NO
                                               attributes:nil
                                                    error:&createDirectoryError];
    
    if (createDirectoryError) {
        NSLog(@"createFolderWithName: error!\n%@", [createDirectoryError localizedDescription]);
        
        NSString *errorMessage = @"";
        
        if ([self.folderName length] == 0) {
            errorMessage = @"Text field is empty. Please, enter a name of the folder";
        } else {
            errorMessage = @"File with this name already exist. Please, enter another name";
        }
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                       message:errorMessage
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
        
    } else {
        NSMutableArray *tempContents = [[NSMutableArray alloc] initWithArray:vc.contents];
        [tempContents insertObject:self.folderName atIndex:0];
        vc.contents = tempContents;
        [vc.tableView reloadData];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
