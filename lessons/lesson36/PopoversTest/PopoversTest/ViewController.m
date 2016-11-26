//
//  ViewController.m
//  PopoversTest
//
//  Created by Руслан on 25.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTDetailsViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful functions

- (void) showControllerAsModal:(UIViewController *)vc withUIBarButtonItem:(UIBarButtonItem *)sender
                      orButton:(UIButton *)button {
    
    if (sender) {
        
        vc.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) / 4,
                                             CGRectGetHeight(self.view.bounds) / 8);
        
        [self presentViewController:vc animated:YES completion:^{
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }];
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        popover.barButtonItem = sender;
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popover.delegate = self;
    } else {
        
        vc.preferredContentSize = CGSizeMake(CGRectGetWidth(self.view.bounds) / 2,
                                             CGRectGetHeight(self.view.bounds) / 10);
        
        [self presentViewController:vc animated:YES completion:^{
            
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self dismissViewControllerAnimated:YES completion:nil];
                });
            }
        }];
        
        UIPopoverPresentationController *popover = [vc popoverPresentationController];
        popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
        popover.delegate = self;
        
        popover.sourceView = self.view;
        popover.sourceRect = button.frame;
    }
    
}

#pragma mark - Actions

- (IBAction)actionAdd:(UIBarButtonItem *)sender {
    
    RTDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RTDetailsViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    navController.modalPresentationStyle = UIModalPresentationPopover;
    [self showControllerAsModal:navController withUIBarButtonItem:sender orButton:nil];
}

- (IBAction)actionPressMe:(UIButton *)sender {
    
    RTDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RTDetailsViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    navController.modalPresentationStyle = UIModalPresentationPopover;
    
    [self showControllerAsModal:navController withUIBarButtonItem:nil orButton:sender];
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    NSLog(@"kek");
    
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue: %@ %@", segue.identifier, NSStringFromClass([segue.destinationViewController class]));
}

@end














