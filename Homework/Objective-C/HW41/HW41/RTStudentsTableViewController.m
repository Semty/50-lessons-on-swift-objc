//
//  RTStudentsTableViewController.m
//  HW41
//
//  Created by Руслан on 22.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTStudentsTableViewController.h"
#import "RTStudentInformationViewController.h"
#import "RTStudentOverallTableViewController.h"
#import "RTStudent+CoreDataClass.h"
#import "RTObject+CoreDataClass.h"
#import "RTDataManager.h"
#import "RTPersonCell.h"

@interface RTStudentsTableViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation RTStudentsTableViewController


@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.navigationItem.title = @"Students";
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
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RTStudent"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Set sort descriptors
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[ firstNameDescriptor, lastNameDescriptor ]];
    
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

- (void)configureCell:(RTPersonCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    RTStudent *student = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.personImage.image = [UIImage imageNamed:@"student"];
    cell.personFullNameLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
    cell.personEmalLabel.text = [NSString stringWithFormat:@"%@", student.email];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.tableView.isEditing) {
        
        RTPersonCell *cell = (RTPersonCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        RTStudentInformationViewController *vc = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"RTStudentInformationViewController"];
        
        vc.titleName = @"Edit Info";
        vc.editCell = cell;
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
        RTStudentOverallTableViewController *vc = [self.storyboard
                                                  instantiateViewControllerWithIdentifier:@"RTStudentOverallTableViewController"];
        
        vc.student = [self.fetchedResultsController objectAtIndexPath:indexPath];
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
    
    if ([segue.identifier isEqualToString:@"newStudent"]) {
        
        RTStudentInformationViewController *vc = [segue destinationViewController];
        
        vc.titleName = @"New Student";
        
    }
    
}


@end
