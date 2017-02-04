//
//  RTCoursesTableViewController.m
//  HW41
//
//  Created by Руслан on 28.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTCoursesTableViewController.h"
#import "RTCourseOverallTableViewController.h"
#import "RTStudent+CoreDataClass.h"
#import "RTObject+CoreDataClass.h"
#import "RTDataManager.h"
#import "RTCourseCell.h"
#import "RTCourse+CoreDataClass.h"
#import "RTCourseInformatonViewController.h"

@interface RTCoursesTableViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation RTCoursesTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.navigationItem.title = @"Courses";
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSFetchedResultsController *)fetchedResultsController
{
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RTCourse"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set sort descriptors
    //NSSortDescriptor *studyBranchDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studyBranch" ascending:YES];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[ /*studyBranchDescriptor,*/ nameDescriptor ]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    [NSFetchedResultsController deleteCacheWithName:@"Master"];
    
    NSError *error = nil;
    if (![aFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = aFetchedResultsController;
    return _fetchedResultsController;
}

#pragma mark - UITableViewDataSource

- (void)configureCell:(RTCourseCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    RTCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.nameLabel.text = course.name;
    cell.teacherLabel.text = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
    cell.numOfStudentsLabel.text = [NSString stringWithFormat:@"%ld", [course.students count]];
}

/*
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo name];
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.tableView.isEditing) {
        
        RTCourseCell *cell = (RTCourseCell *)[tableView cellForRowAtIndexPath:indexPath];
        RTCourse *course = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForCell:cell]];
        
        RTCourseInformatonViewController *vc = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"RTCourseInformatonViewController"];
        
        vc.titleName = @"Edit Info";
        vc.editCell = cell;
        vc.editCourse = course;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        RTCourseOverallTableViewController *vc = [self.storyboard
                                                   instantiateViewControllerWithIdentifier:@"RTCourseOverallTableViewController"];
        
        vc.course = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"imageItem";
    
    UICollectionViewCell *imageItem = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                                forIndexPath:indexPath];
    return imageItem;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"newCourse"]) {
        
        RTCourseInformatonViewController *vc = [segue destinationViewController];
        vc.titleName = @"New Course";
        
    }
    
}

@end







