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
    self.tableView.editing = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.groupsArray = [[NSMutableArray alloc] init];
    
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
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.groupsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.groupsArray objectAtIndex:section] name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.groupsArray objectAtIndex:section] students] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    RTGroup *group = [self.groupsArray objectAtIndex:indexPath.section];
    RTStudent *student = [group.students objectAtIndex:indexPath.row];
    
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

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*
    RTGroup *sourceGroup = [self.groupsArray objectAtIndex:indexPath.section];
    RTStudent *student = [sourceGroup.students objectAtIndex:indexPath.row];
    
    return student.averageGrade < 4;
     */
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    RTGroup *sourceGroup = [self.groupsArray objectAtIndex:sourceIndexPath.section];
    RTStudent *student = [sourceGroup.students objectAtIndex:sourceIndexPath.row];
    
    NSMutableArray *tempStudents = [[NSMutableArray alloc] initWithArray:sourceGroup.students];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempStudents exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
        sourceGroup.students = tempStudents;
        
    } else {
        
        [tempStudents removeObject:student];
        sourceGroup.students = tempStudents;
        
        RTGroup *destinationGroup = [self.groupsArray objectAtIndex:destinationIndexPath.section];
        
        tempStudents = [[NSMutableArray alloc] initWithArray:destinationGroup.students];
        [tempStudents insertObject:student atIndex:destinationIndexPath.row];
        
        destinationGroup.students = tempStudents;
    }
    
}

#pragma mark = UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleNone;
    
}


@end








