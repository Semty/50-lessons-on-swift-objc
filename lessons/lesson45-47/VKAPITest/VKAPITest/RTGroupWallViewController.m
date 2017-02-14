//
//  RTGroupWallViewController.m
//  VKAPITest
//
//  Created by Руслан on 14.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTGroupWallViewController.h"
#import "RTServerManager.h"
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>
#import "RTPostCell.h"

#import "RTUser.h"
#import "RTPost.h"

@interface RTGroupWallViewController ()

@property (strong, nonatomic) NSMutableArray *postsArray;
@property (assign, nonatomic) BOOL firstTimeAppear;

@end

@implementation RTGroupWallViewController

static NSInteger postsInRequest = 5;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.postsArray = [[NSMutableArray alloc] init];
    
    self.firstTimeAppear = YES;
    
    UIRefreshControl *refreshWall = [[UIRefreshControl alloc] init];
    [refreshWall addTarget:self action:@selector(refreshWall) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl = refreshWall;
    
    UIBarButtonItem *newPostItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(actionNewPost:)];
    self.navigationItem.rightBarButtonItem = newPostItem;
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

- (void) getPostsFromServer {
    
    [[RTServerManager sharedManager]
     getGroupWall:@"iosdevcourse"
     withOffset:[self.postsArray count]
     count:postsInRequest
     onSuccess:^(NSArray *posts) {
         
         [self.postsArray addObjectsFromArray:posts];
         
         NSMutableArray *newPaths = [[NSMutableArray alloc] init];
         for (int i = (int)[self.postsArray count] - (int)[posts count]; i < [self.postsArray count]; i++) {
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
    return [self.postsArray count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"PostCell";
    
    RTPostCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    //cell.imageView.layer.cornerRadius = 25.f;
    //cell.imageView.clipsToBounds = YES;
    //cell.imageView.layer.borderWidth = 1.f;
    //cell.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if (indexPath.row == [self.postsArray count]) {
        
        cell.postTextLabel.text = @"LOAD MORE";
        cell.postTextLabel.textAlignment = NSTextAlignmentCenter;
    } else {
        
        RTPost *post = [self.postsArray objectAtIndex:indexPath.row];
        
        cell.postTextLabel.text = [NSString stringWithFormat:@"%@",  post.text];
        cell.postTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == [self.postsArray count]) {
        
        return 44.f;
        
    } else {
        
        RTPost *post = [self.postsArray objectAtIndex:indexPath.row];
        
        return [RTPostCell heightForText:post.text];
    }
    return 44.f;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == [self.postsArray count]) {
        [self getPostsFromServer];
    }
}

#pragma mark - Actions

- (void) refreshWall {
    
    [[RTServerManager sharedManager]
     getGroupWall:@"iosdevcourse"
     withOffset:0
     count:MAX([self.postsArray count], postsInRequest)
     onSuccess:^(NSArray *posts) {
         
         [self.postsArray removeAllObjects];
         
         [self.postsArray addObjectsFromArray:posts];
         
         [self.tableView reloadData];
         
         [self.refreshControl endRefreshing];
     }
     onFailure:^(NSError *error, NSInteger statusCode) {
         
         NSLog(@"\n\nERROR: %@,\nSTATUS CODE: %ld\n\n",
               [error localizedDescription], statusCode);
         [self.refreshControl endRefreshing];
     }];
}

- (void) actionNewPost:(UIBarButtonItem *)barButtonItem {
    
    [[RTServerManager sharedManager] postText:@"🙃 Это тест из урока номер 47! Думал, что никогда не дойду до этого момента :D 🙃"
                                  onGroupWall:@"-58860049"
                                    onSuccess:^(NSDictionary *result) {
                                        
                                    }
                                    onFailure:^(NSError *error, NSInteger statusCode) {
                                        NSLog(@"\n\nERROR: %@,\nSTATUS CODE: %ld\n\n",
                                              [error localizedDescription], statusCode);
                                        [self.refreshControl endRefreshing];
                                    }];
    
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











