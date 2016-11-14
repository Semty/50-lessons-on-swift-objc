//
//  RTDirectoryViewController.m
//  FileManagerTest
//
//  Created by Руслан on 13.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDirectoryViewController.h"
#import "RTFileCell.h"
#import "UIView+UITableViewCell.h"

@interface RTDirectoryViewController ()

@property (strong, nonatomic) NSArray *contents;
@property (strong, nonatomic) NSString *selectedPath;

@end

@implementation RTDirectoryViewController

- (instancetype) initWithFolderPath:(NSString *)path
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        self.path = path;
    }
    ///Users/ruslan/Desktop/iOSDevCourse
    return self;
}

- (void) setPath:(NSString *)path {
    
    _path = path;
    NSError *error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path
                                                                        error:&error];
    if (error) {
        NSLog(@"\n\n%@\n\n", [error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [_path lastPathComponent];
}

- (void) dealloc {
    NSLog(@"controller with path %@ has been deallocated", self.path);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.path) {
        self.path = @"/Users/ruslan/Desktop/iOSDevCourse";
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"home.png"]
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
    NSLog(@"index on stack = %ld\n\n", [self.navigationController.viewControllers indexOfObject:self]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) actionBackToRoot:(UIBarButtonItem *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)actionInfoCell:(UIButton *)sender {
    
    NSLog(@"actionInfoCell:");
    
    UITableViewCell *cell = [sender superCell];
    
    if (cell) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Yahoo!"
                                            message:[NSString stringWithFormat:@"Action in section %ld row %ld",
                                                     indexPath.section, indexPath.row]
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:nil];
        [alert addAction:actionOk];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

#pragma mark - Helpful functions

- (BOOL) isDerictoryAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    BOOL isDirectory = NO;
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

- (NSString *) fileSizeFromValue:(unsigned long long)size {
    
    static NSString *units[] = { @"B", @"KB", @"MB", @"GB", @"TB" };
    static NSInteger unitsCount = 5;
    
    int index = 0;
    
    double fileSize = (double)size;
    
    while (fileSize > 1024 && index < unitsCount) {
        fileSize /= 1024;
        index++;
    }
    return [NSString stringWithFormat:@"%1.f %@", fileSize, units[index]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *fileIdentifier = @"fileIdentifier";
    static NSString *folderIdentifier = @"folderIdentifier";
    
    BOOL isDirectory = [self isDerictoryAtIndexPath:indexPath];
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    if (isDirectory) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
        
        cell.textLabel.text = fileName;
        
        return cell;
    } else {
        
        NSString *path = [self.path stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
        static NSDateFormatter *dateFormatter = nil;
        
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"dd.MM.yyyy hh:mm"];
        }
        NSString *stringDate = [dateFormatter stringFromDate:[attributes fileModificationDate]];
        
        RTFileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
        
        cell.nameLabel.text = fileName;
        cell.sizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
        cell.dateLabel.text = [NSString stringWithFormat:@"%@", stringDate];
        
        return cell;
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self isDerictoryAtIndexPath:indexPath]) {
        
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        
        NSString *path = [self.path stringByAppendingPathComponent:fileName];
        
        // 1)
        //RTDirectoryViewController *vc = [[RTDirectoryViewController alloc] initWithFolderPath:path];
        //[self.navigationController pushViewController:vc animated:YES];
        
        // 2)
        //UIStoryboard *storyBoard = self.storyboard;
        //RTDirectoryViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"RTDirectoryViewController"];
        //vc.path = path;
        //[self.navigationController pushViewController:vc animated:YES];
        
        // 3)
        
        self.selectedPath = path;
        [self performSegueWithIdentifier:@"navigateDeep" sender:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self isDerictoryAtIndexPath:indexPath]) {
        return 44.f;
    } else {
        return 100.f;
    }
    
}

#pragma mark - Segue

- (BOOL) shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    NSLog(@"shouldPerformSegueWithIdentifier: %@", identifier);
    
    return YES;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"prepareForSegue: %@", segue.identifier);
    
    RTDirectoryViewController *vc = segue.destinationViewController;
    vc.path = self.selectedPath;
}

@end











