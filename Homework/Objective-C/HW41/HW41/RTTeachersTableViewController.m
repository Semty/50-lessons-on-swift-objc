//
//  RTTeachersTableViewController.m
//  HW41
//
//  Created by Руслан on 04.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTTeachersTableViewController.h"
#import "RTStudentOverallTableViewController.h"
#import "RTStudent+CoreDataClass.h"
#import "RTCourse+CoreDataClass.h"
#import "RTTeacherInfoCell.h"

@interface RTTeachersTableViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation RTTeachersTableViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Teachers";
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
    NSSortDescriptor *studyBranchDescriptor = [[NSSortDescriptor alloc] initWithKey:@"studyBranch" ascending:YES];
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"teacher.firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"teacher.lastName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[ studyBranchDescriptor, firstNameDescriptor, lastNameDescriptor ]];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:@"studyBranch"
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

- (void)configureCell:(RTTeacherInfoCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    RTCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.fullNameLabel.text = [NSString stringWithFormat:@"%@ %@", course.teacher.firstName, course.teacher.lastName];
    cell.numberOfCoursesLabel.text = [NSString stringWithFormat:@"%ld", [course.teacher.teachingCourses count]];
}


 - (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
 return [sectionInfo name];
 }
 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    RTStudentOverallTableViewController *vc = [self.storyboard
                                               instantiateViewControllerWithIdentifier:@"RTStudentOverallTableViewController"];
    
    RTCourse *course = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    vc.student = course.teacher;
    
    [self.navigationController pushViewController:vc animated:YES];
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
    
    
    
}

@end






