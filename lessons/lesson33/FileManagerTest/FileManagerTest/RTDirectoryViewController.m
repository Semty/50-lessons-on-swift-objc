//
//  RTDirectoryViewController.m
//  FileManagerTest
//
//  Created by Руслан on 13.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDirectoryViewController.h"

@interface RTDirectoryViewController ()

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSArray *contents;

@end

@implementation RTDirectoryViewController

- (instancetype) initWithFolderPath:(NSString *)path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
        NSError *error = nil;
        
        self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                            error:&error];
        if (error) {
            NSLog(@"\n\n%@\n\n", [error localizedDescription]);
        }
    }
    return self;
}

- (void) dealloc {
    NSLog(@"controller with path %@ has been deallocated", self.path);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = [self.path lastPathComponent];
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Go to Root"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionBackToRoot:)];
        self.navigationItem.rightBarButtonItem = item;
        
    }
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"path = %@", self.path);
    NSLog(@"view controllers on stack = %ld", [self.navigationController.viewControllers count]);
    NSLog(@"index on stack = %ld", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionBackToRoot:(UIBarButtonItem *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Helpful functions

- (BOOL) isDerictoryAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    BOOL isDirectory = NO;
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    cell.textLabel.text = fileName;
    
    BOOL isDirectory = [self isDerictoryAtIndexPath:indexPath];
    
    if (isDirectory) {
        
        cell.imageView.image = [UIImage imageNamed:@"folder.png"];
    } else {
        
        cell.imageView.image = [UIImage imageNamed:@"file.png"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDerictoryAtIndexPath:indexPath]) {
        
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString *path = [self.path stringByAppendingPathComponent:fileName];
        
        RTDirectoryViewController *vc = [[RTDirectoryViewController alloc] initWithFolderPath:path];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

@end











