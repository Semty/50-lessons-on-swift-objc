//
//  ViewController.m
//  TableEditingPart1Test
//
//  Created by Руслан on 07.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTGroup.h"
#import "RTStudent.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *groupsArray;

@end

@implementation ViewController

- (void) loadView {
    [super loadView];
    
    CGRect frame = self.view.bounds;
    frame.origin = CGPointZero;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame
                                                          style:UITableViewStyleGrouped];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
    self.tableView.allowsSelectionDuringEditing = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupsArray = [[NSMutableArray alloc] init];
    
    /*
    for (int i = 0; i < arc4random() % 6 + 5; i++) {
        
        RTGroup *group = [[RTGroup alloc] init];
        group.name = [NSString stringWithFormat:@"Group #%d", i];
        
        NSMutableArray *students = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < arc4random() % 11 + 15; j++) {
            
            RTStudent *student = [RTStudent randomStudent];
            
            [students addObject:student];
        }
        
        group.students = students;
        [self.groupsArray addObject:group];
    }
     */
    
    [self.tableView reloadData];
    
    self.navigationItem.title = @"Students";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                target:self
                                                                                action:@selector(actionAddSection:)];
    
    self.navigationItem.leftBarButtonItem = addButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions for UIBarButtonItem buttons

- (void) actionEdit:(UIBarButtonItem *)sender {
    
    BOOL isEditing = self.tableView.isEditing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemDone;
    
    if (isEditing) {
        item = UIBarButtonSystemItemEdit;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]
                                              initWithBarButtonSystemItem:item
                                              target:self
                                              action:@selector(actionEdit:)];
}

- (void) actionAddSection:(UIBarButtonItem *)sender {
    
    RTGroup *group = [[RTGroup alloc] init];
    group.name = [NSString stringWithFormat:@"Group #%lu", [self.groupsArray count]];
    group.students = @[ [RTStudent randomStudent], [RTStudent randomStudent] ];
    
    NSInteger newSectionIndex = 0;
    
    [self.groupsArray insertObject:group atIndex:newSectionIndex];
    
    [self.tableView beginUpdates];
    
    NSIndexSet *insertSections = [NSIndexSet indexSetWithIndex:newSectionIndex];
    
    [self.tableView insertSections:insertSections
                  withRowAnimation: [self.groupsArray count] % 2 ? UITableViewRowAnimationLeft : UITableViewRowAnimationRight];
    
    [self.tableView endUpdates];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.groupsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.groupsArray objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.groupsArray objectAtIndex:section] students] count] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        static NSString *addStuentIdentifier = @"addStuentCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:addStuentIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:addStuentIdentifier];
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.textLabel.alpha = 0.75f;
            cell.textLabel.text = @"Tap to add new student";
        }
        
        return cell;
        
    } else {
        
        static NSString *studentIdentifier = @"studentCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:studentIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:studentIdentifier];
        }
        
        RTGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        RTStudent *student = [group.students objectAtIndex:indexPath.row - 1];
        
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", student.firstName, student.lastName];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.2f", student.averageGrade];
        
        if (student.averageGrade >= 4.f) {
            cell.detailTextLabel.textColor = [UIColor greenColor];
        } else if (student.averageGrade >= 3.f) {
            cell.detailTextLabel.textColor = [UIColor orangeColor];
        } else {
            cell.detailTextLabel.textColor = [UIColor redColor];
        }
        
        return cell;
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    RTGroup *sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
    RTStudent *student = [sourceGroup.students objectAtIndex:indexPath.row];
    
    return student.averageGrade < 4;
     */
    
    return indexPath.row > 0;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    RTGroup *sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    RTStudent *student = [sourceGroup.students objectAtIndex:sourceIndexPath.row - 1];
    
    NSMutableArray *tempStudents = [[NSMutableArray alloc] initWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempStudents removeObjectAtIndex:sourceIndexPath.row - 1];
        [tempStudents insertObject:student atIndex:destinationIndexPath.row - 1];
        sourceGroup.students = tempStudents;
        
    } else {
        
        [tempStudents removeObject:student];
        sourceGroup.students = tempStudents;
        
        RTGroup *destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        
        tempStudents = [[NSMutableArray alloc] initWithArray:destinationGroup.students];
        [tempStudents insertObject:student atIndex:destinationIndexPath.row - 1];
        
        destinationGroup.students = tempStudents;
    }
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        RTGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        RTStudent *student = [group.students objectAtIndex:indexPath.row - 1];
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithArray:group.students];
        [tempArray removeObject:student];
        
        group.students = tempArray;
        
        [self.tableView beginUpdates];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
    }
    
}

#pragma mark = UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row == 0 ? UITableViewCellEditingStyleNone : UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    if (proposedDestinationIndexPath.row == 0) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        RTGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
        
        NSMutableArray *tempArray = nil;
        
        if (group.students) {
            tempArray = [[NSMutableArray alloc] initWithArray:group.students];
        } else {
            tempArray = [[NSMutableArray alloc] init];
        }
        
        NSInteger newStudentIndex = 0;
        
        [tempArray insertObject:[RTStudent randomStudent] atIndex:newStudentIndex];
        group.students = tempArray;

        [self.tableView beginUpdates];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForItem:newStudentIndex + 1 inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        [self.tableView endUpdates];
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}


@end
