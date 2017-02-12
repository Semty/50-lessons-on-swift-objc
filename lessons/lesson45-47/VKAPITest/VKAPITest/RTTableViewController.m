//
//  RTTableViewController.m
//  VKAPITest
//
//  Created by Руслан on 11.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTTableViewController.h"
#import "RTServerManager.h"
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>
#import "RTUser.h"

@interface RTTableViewController ()

@property (strong, nonatomic) NSMutableArray *friendsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation RTTableViewController

static NSInteger friendsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.friendsArray = [[NSMutableArray alloc] init];
    
    self.firstTimeAppear = YES;
    
    //[self getFriendsFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.firstTimeAppear) {
        
        [[RTServerManager sharedManager] authorizeUser:^(RTUser *user) {
            NSLog(@"AUTHORIZED\n");
            NSLog(@"%@ %@\n\n", user.firstName, user.lastName);
        }];
        
        self.firstTimeAppear = NO;
    }
}

#pragma mark - VK API

- (void) getFriendsFromServer {
    
    [[RTServerManager sharedManager]
     
     getFriendsWithOffset:[self.friendsArray count]
     
                    count:friendsInRequest
     
                onSuccess:^(NSArray *friends) {
                    
                    [self.friendsArray addObjectsFromArray:friends];
                    
                    NSMutableArray *newPaths = [[NSMutableArray alloc] init];
                    for (int i = (int)[self.friendsArray count] - (int)[friends count]; i < [self.friendsArray count]; i++) {
                        [newPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                    
                    [self.tableView beginUpdates];
                    [self.tableView insertRowsAtIndexPaths:newPaths withRowAnimation:UITableViewRowAnimationAutomatic];
                    [self.tableView endUpdates];
                }
     
                onFailure:^(NSError *error, NSInteger statusCode) {
                                                    
                NSLog(@"\n\nERROR: %@,\nSTATUS CODE: %ld\n\n",
                [error localizedDescription], statusCode);
                    
                }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friendsArray count] + 1;
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    cell.imageView.layer.cornerRadius = 25.f;
    cell.imageView.clipsToBounds = YES;
    //cell.imageView.layer.borderWidth = 1.f;
    //cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (indexPath.row == [self.friendsArray count]) {
        
        cell.textLabel.text = @"LOAD MORE";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.imageView.image = nil;
    } else {
        
        RTUser *user = [self.friendsArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",  user.firstName, user.lastName];
        
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        
        __weak UITableViewCell *weakCell = cell;
        
        [cell.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:user.imageURL]
                              placeholderImage:nil
         
                                       success:^(NSURLRequest * _Nonnull request,
                                                 NSHTTPURLResponse * _Nullable response,
                                                 UIImage * _Nonnull image) {
                                           
                                           weakCell.imageView.image = image;
                                           [weakCell layoutSubviews];
                                           
                                       }
                                       failure:^(NSURLRequest * _Nonnull request,
                                                 NSHTTPURLResponse * _Nullable response,
                                                 NSError * _Nonnull error) {
                                           
                                           weakCell.imageView.image = [UIImage imageNamed:@"cross"];
                                           [weakCell layoutSubviews];
                                           
                                       }];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.friendsArray count]) {
        [self getFriendsFromServer];
    }
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
