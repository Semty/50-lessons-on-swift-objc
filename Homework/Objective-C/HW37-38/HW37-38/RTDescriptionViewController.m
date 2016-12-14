//
//  RTDescriptionVeiwController.m
//  HW37-38
//
//  Created by Руслан on 10.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDescriptionViewController.h"

@interface RTDescriptionViewController ()

@end

@implementation RTDescriptionViewController

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

- (IBAction)actionOKPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
