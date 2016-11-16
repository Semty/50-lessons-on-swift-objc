//
//  RTDirectoryViewController.m
//  HW33-34
//
//  Created by Руслан on 15.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTDirectoryViewController.h"
#import "RTNewFolderViewController.h"
#import "RTFolderCell.h"
#import "RTFileCell.h"
#import "RTAddCell.h"

@interface RTDirectoryViewController ()

@property (strong, nonatomic) NSString *selectedPath;
@property (strong, nonatomic) NSMutableArray *files;
@property (strong, nonatomic) NSMutableArray *folders;
@property (assign, nonatomic) NSInteger countFiles;

@end

static NSString *addCellIdentifier = @"addIdentifier";

@implementation RTDirectoryViewController

#pragma mark - Initialization

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        self.path = path;
    }
    return self;
}

#pragma mark - Redefeniton of self.path setter

- (void) setPath:(NSString *)path {
    
    _path = path;
    NSError *error = nil;
    
    self.contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    
    if (error) {
        NSLog(@"Error in setPath (%@)\nError text: %@", path, [error localizedDescription]);
    }
    
    [self.tableView reloadData];
    
    self.navigationItem.title = [path lastPathComponent];
}

#pragma mark - Load of the programm

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.folders = [[NSMutableArray alloc] init];
    self.files = [[NSMutableArray alloc] init];
    
    if (!self.path) {
        self.path = @"/Users/ruslan/Desktop/iOSDevCourse";
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self sortCells];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (!([self.navigationController.viewControllers count] > 1)) {
        
        self.navigationItem.rightBarButtonItem.enabled = NO;;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)actionToRoot:(UIBarButtonItem *)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)ationEdit:(UIBarButtonItem *)button {
    
    if (![[self.contents firstObject] isEqualToString:addCellIdentifier]) {
        
        [self.tableView beginUpdates];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self insertAddCellToTableView];
        
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView endUpdates];
        
        NSArray *rigthBarButtons = @[ self.navigationItem.rightBarButtonItem,
                                          [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(ationEdit:)] ];
            self.navigationItem.rightBarButtonItems = rigthBarButtons;
        
        [self.tableView setEditing:YES animated:YES];
        [self punishToTapDuringAnimation];
        
    } else {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self deleteAddCellToTableViewWithIndexPath:indexPath];
    }
}


#pragma mark - Helpful functions

- (NSString *) formatDateFromAttributes:(NSDictionary *)attributes {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd.MM.YY"];
    
    return [formatter stringFromDate:[attributes fileCreationDate]];
}

- (NSString *) folderSizeFromFolderPath:(NSString *)folderPath {

    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:folderPath error:nil];
    
    NSEnumerator *enumerator = [files objectEnumerator];
    NSString *fileName;
    NSInteger folderSize = 0;
    
    self.countFiles = 0;
    
    while (fileName = [enumerator nextObject]) {
        
        NSString *path = [folderPath stringByAppendingPathComponent:fileName];
        NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        folderSize += [attributes fileSize];
        self.countFiles += 1;
    }
    return [self fileSizeFromValue:folderSize];
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

- (void) sortCells {
    
    int startIndex = 0;

    NSInteger endIndex = [self.contents count];
    
    for (int i = startIndex; i < endIndex; i++) {
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        
        if ([self isDirectoryAtIndexPath:indexPath]) {
            [self.folders addObject:fileName];
        } else {
            [self.files addObject:fileName];
        }
    }
    
    [self.folders sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    [self.files sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tempContents = [[NSMutableArray alloc] init];
    [tempContents addObjectsFromArray:self.folders];
    [tempContents addObjectsFromArray:self.files];
    //NSLog(@"%@\n\n%@\n\n\n%@", self.navigationItem.title, self.folders, self.files);
    
    [self.folders removeAllObjects];
    [self.files removeAllObjects];
    
    self.contents = tempContents;
}

- (BOOL) isHiddenAtIndexPathRow:(NSInteger)row {
    
    NSString *item = [self.contents objectAtIndex:row];
    NSString *firstChar = [item substringWithRange:NSMakeRange(0, 1)];
    
    if ([firstChar isEqualToString:@"."]) {
        return YES;
    } else {
        return NO;
    }
}

- (void) punishToTapDuringAnimation {
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] endIgnoringInteractionEvents];
    });
    
}

- (BOOL) isDirectoryAtIndexPath:(NSIndexPath *)indexPath {
    
    BOOL isDirectory = NO;
    
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    
    NSString *filePath = [self.path stringByAppendingPathComponent:fileName];
    
    [[NSFileManager defaultManager] fileExistsAtPath:filePath isDirectory:&isDirectory];
    
    return isDirectory;
}

- (void) insertAddCellToTableView {
    
    NSMutableArray *tempContents = [[NSMutableArray alloc] initWithArray:self.contents];
    
    [tempContents insertObject:addCellIdentifier atIndex:0];
    
    self.contents = tempContents;
}

- (void) deleteAddCellToTableViewWithIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    NSMutableArray *tempContents = [[NSMutableArray alloc] initWithArray:self.contents];
    
    [tempContents removeObject:addCellIdentifier];
    
    self.contents = tempContents;
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
    NSArray *rigthBarButtons = @[ self.navigationItem.rightBarButtonItem,
                                  [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                  target:self
                                                                                  action:@selector(ationEdit:)] ];
    
    self.navigationItem.rightBarButtonItems = rigthBarButtons;
    [self.tableView setEditing:NO animated:YES];
    [self punishToTapDuringAnimation];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.contents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *folderIdentifier = @"folderIdentifier";
    static NSString *fileIdentifier = @"fileIdentifier";
    NSString *fileName = [self.contents objectAtIndex:indexPath.row];
    NSDictionary *attributes = [[NSFileManager defaultManager] attributesOfItemAtPath:
                                [self.path stringByAppendingPathComponent:fileName]
                                                                                error:nil];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        RTFolderCell *cell = [tableView dequeueReusableCellWithIdentifier:folderIdentifier];
        
        if ([self isHiddenAtIndexPathRow:indexPath.row]) {
            cell.nameLabel.textColor = [UIColor lightGrayColor];
            
            RTFolderCell *folderCell = (RTFolderCell *)cell;
            folderCell.folderImage.alpha = 0.4f;
            cell = folderCell;
        }
        
        cell.nameLabel.text = fileName;
        cell.folderSizeLabel.text = [self folderSizeFromFolderPath:[self.path stringByAppendingPathComponent:fileName]];
        cell.dateLabel.text = [self formatDateFromAttributes:attributes];
        cell.backgroundColor = [UIColor lightTextColor];
        
        return cell;
    } else if (![fileName isEqualToString:addCellIdentifier]) {
        
        RTFileCell *cell = [tableView dequeueReusableCellWithIdentifier:fileIdentifier];
        
        if ([self isHiddenAtIndexPathRow:indexPath.row]) {
            cell.nameLabel.textColor = [UIColor lightGrayColor];
            
            RTFileCell *fileCell = (RTFileCell *)cell;
            fileCell.fileImage.alpha = 0.4f;
            cell = fileCell;
        }
        
        cell.nameLabel.text = fileName;
        cell.fileSizeLabel.text = [self fileSizeFromValue:[attributes fileSize]];
        cell.fileSizeLabel.textColor = [UIColor darkGrayColor];
        cell.dateLabel.text = [self formatDateFromAttributes:attributes];
        cell.backgroundColor = [UIColor lightTextColor];
        
        return cell;
    } else {
        
        RTAddCell *cell = [self.tableView dequeueReusableCellWithIdentifier:addCellIdentifier];
        cell.backgroundColor = [UIColor lightTextColor];
        
        return cell;
    }

}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {

    return ![[self.contents objectAtIndex:indexPath.row] isEqualToString:addCellIdentifier];
}

//                                                          ***DELETE ROWS***

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *fileName = [self.contents objectAtIndex:indexPath.row];
        __block NSError *error = nil;
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure?"
                                                                       message:nil
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionYes = [UIAlertAction actionWithTitle:@"Yes"
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              
                                                              dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                  NSMutableArray *tempArray = [[NSMutableArray alloc]
                                                                                               initWithArray:self.contents];
                                                                  [tempArray removeObject:fileName];
                                                                  self.contents = tempArray;
                                                                  
                                                                  NSString *removePath = [self.path
                                                                                          stringByAppendingPathComponent:fileName];
                                                                  
                                                                  [[NSFileManager defaultManager] removeItemAtPath:removePath
                                                                                                             error:&error];
                                                                  
                                                                  [self.tableView beginUpdates];
                                                                  [tableView deleteRowsAtIndexPaths:@[indexPath]
                                                                                   withRowAnimation:UITableViewRowAnimationFade];
                                                                  [self.tableView endUpdates];
                                                              });
                                                          }];
        
        UIAlertAction *actionNo = [UIAlertAction actionWithTitle:@"No"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                                                 [self.tableView setEditing:NO animated:YES];
                                                             });
                                                         }];
        [alert addAction:actionYes];
        [alert addAction:actionNo];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"RTNewFolderViewController"]) {
        [self deleteAddCellToTableViewWithIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *filePath = [self.path stringByAppendingPathComponent:[self.contents objectAtIndex:indexPath.row]];
    
    if ([self isDirectoryAtIndexPath:indexPath]) {
        
        UIStoryboard *storyBoard = self.storyboard;
        RTDirectoryViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"RTDirectoryViewController"];
        vc.path = filePath;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [[self.contents objectAtIndex:indexPath.row] isEqualToString:addCellIdentifier] ? 44.f : 70.f;
}

@end















