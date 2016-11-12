//
//  ViewController.m
//  HW31-32
//
//  Created by Руслан on 12.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTFootballClub.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *footballLeagues;

@end

@implementation ViewController

- (void) loadView {
    [super loadView];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds
                                                          style:UITableViewStyleGrouped];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
    
    self.tableView = tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.footballLeagues = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 2; i++) {
        
        NSArray *randomLeague = [RTFootballClub randomFootballLeague];
        randomLeague = [self sortedByPoints:randomLeague];
        [self.footballLeagues addObject:randomLeague];
    }
    
    self.navigationItem.title = @"English Football Leagues";
    
    UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(actionEdit:)];
    self.navigationItem.rightBarButtonItem = editButton;
    
    UIBarButtonItem *newLeagueButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                     target:self
                                                                                     action:@selector(actionNewLeague:)];
    self.navigationItem.leftBarButtonItem = newLeagueButton;
    
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions : Edit and Add

- (void) actionEdit:(UIBarButtonItem *)editButton {
    
    BOOL isEditing = self.tableView.isEditing;
    
    [self.tableView setEditing:!isEditing animated:YES];
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemDone;
    
    if (isEditing) {
        item = UIBarButtonSystemItemEdit;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:item
                                                                                           target:self
                                                                                           action:@selector(actionEdit:)];
    
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
            [[UIApplication sharedApplication] endIgnoringInteractionEvents];
        }
    });
}

- (void) actionNewLeague:(UIBarButtonItem *)newLeague {
    
    NSArray *league = [RTFootballClub makeEmptyLeague];
    [self.footballLeagues insertObject:league atIndex:0];
    
    [self.tableView beginUpdates];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
    [self.tableView insertSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
    
}

#pragma mark - Helpful functions

- (NSArray *) sortedByPoints:(NSArray *)array {
    
    array = [array sortedArrayUsingComparator:^NSComparisonResult(RTFootballClub *club1, RTFootballClub *club2) {
        
        return club1.points < club2.points;
        
    }];
    
    return array;
}

- (UIColor *) pointsColor:(NSInteger)points {
    
    if (points < 30) {
        return [UIColor redColor];
    } else if (points < 60) {
        return [UIColor orangeColor];
    } else if (points < 90) {
        return [UIColor magentaColor];
    } else {
        return [UIColor greenColor];
    }
}

- (UITableViewCell *) addFirstCell {
    
    UITableViewCell *firstCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:@"firstCell"];
    firstCell.textLabel.text = @"Tap to add new club";
    firstCell.textLabel.textColor = [UIColor lightGrayColor];
    firstCell.textLabel.alpha = 0.75f;
    
    return firstCell;
}

- (UITableViewCell *) addLastCell {
    
    UITableViewCell *lastCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                        reuseIdentifier:@"lastCell"];
    lastCell.textLabel.text = @"Tap to delete this league";
    lastCell.textLabel.textColor = [UIColor lightGrayColor];
    lastCell.textLabel.alpha = 0.75f;
    
    return lastCell;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.footballLeagues objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.footballLeagues count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[[self.footballLeagues objectAtIndex:section] firstObject] league];
}

//                                                  *** DATA ROWS ***

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger lastIndex = [[self.footballLeagues objectAtIndex:indexPath.section] count] - 1;
    
    if (indexPath.row == 0) {
        
        static NSString *identifier = @"firstCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [self addFirstCell];
        }
        
        return cell;
    } else if (indexPath.row != lastIndex) {
        
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        }
        
        RTFootballClub *club = [[self.footballLeagues objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        cell.textLabel.text = club.name;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", club.points];
        cell.detailTextLabel.textColor = [self pointsColor:club.points];
        
        return cell;
    } else {
        
        static NSString *identifier = @"lastCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [self addLastCell];
        }
        
        return cell;
        
    }
}
//                                              --------------------------

//                                                  *** MOVING ROWS ***

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger lastIndex = [[self.footballLeagues objectAtIndex:indexPath.section] count] - 1;
    
    return indexPath.row != 0 && indexPath.row != lastIndex ? YES : NO;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
                                                  toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSArray *sourceLeague = [self.footballLeagues objectAtIndex:sourceIndexPath.section];
    
    RTFootballClub *sourceClub = [sourceLeague objectAtIndex:sourceIndexPath.row];
    NSMutableArray *tempLeague = [[NSMutableArray alloc] initWithArray:sourceLeague];
    
    if (sourceIndexPath.section == destinationIndexPath.section) {
        
        [tempLeague removeObject:sourceClub];
        [tempLeague insertObject:sourceClub atIndex:destinationIndexPath.row];
        [self.footballLeagues setObject:tempLeague atIndexedSubscript:sourceIndexPath.section];
        
    } else {
        
        [tempLeague removeObject:sourceClub];
        [self.footballLeagues setObject:tempLeague atIndexedSubscript:sourceIndexPath.section];
        
        NSArray *destinationLeague = [self.footballLeagues objectAtIndex:destinationIndexPath.section];
        tempLeague = [[NSMutableArray alloc] initWithArray:destinationLeague];
        
        sourceClub.league = [[tempLeague firstObject] league];
        [tempLeague insertObject:sourceClub atIndex:destinationIndexPath.row];
        [self.footballLeagues setObject:tempLeague atIndexedSubscript:destinationIndexPath.section];
    }
    
    [self.tableView reloadData];
}
//                                              --------------------------

//                                                  *** DELETE ROWS ***

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
                                            forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSArray *footballLeague = [self.footballLeagues objectAtIndex:indexPath.section];
        RTFootballClub *club = [footballLeague objectAtIndex:indexPath.row];
        
        NSMutableArray *tempFootballLeague = [[NSMutableArray alloc] initWithArray:footballLeague];
        [tempFootballLeague removeObject:club];
        [self.footballLeagues setObject:tempFootballLeague atIndexedSubscript:indexPath.section];
    }
    
    [self.tableView beginUpdates];
    
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self.tableView endUpdates];
}

//                                              --------------------------

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger lastIndex = [[self.footballLeagues objectAtIndex:indexPath.section] count] - 1;
    
    return indexPath.row != 0 && indexPath.row != lastIndex ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Remove";
}

//                                                  *** ADDING ROWS ***

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger lastIndex = [[self.footballLeagues objectAtIndex:indexPath.section] count] - 1;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        __block NSArray *league = [self.footballLeagues objectAtIndex:indexPath.section];
        NSMutableArray *tempLeague = [[NSMutableArray alloc] initWithArray:league];
        
        RTFootballClub *newFootballClub = [RTFootballClub randomFootballClub];
        
        [tempLeague insertObject:newFootballClub atIndex:1]; // because at index 0 we have "default club"
        league = tempLeague;
        [self.footballLeagues setObject:league atIndexedSubscript:indexPath.section];
        
        [self.tableView beginUpdates];
        
        NSIndexPath *firstIndexPath = [NSIndexPath indexPathForRow:1
                                                         inSection:indexPath.section];
        
        [self.tableView insertRowsAtIndexPaths:@[firstIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView endUpdates];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            league = [self sortedByPoints:tempLeague];
            [self.footballLeagues setObject:league atIndexedSubscript:indexPath.section];
            
            [self.tableView beginUpdates];
            
            NSIndexPath *startIndexPath = [NSIndexPath indexPathForRow:1 inSection:indexPath.section];
            
            NSIndexPath *endIndexPath = [NSIndexPath indexPathForRow:[league indexOfObject:newFootballClub]
                                                           inSection:indexPath.section];
            
            [self.tableView moveRowAtIndexPath:startIndexPath toIndexPath:endIndexPath];
            
            [self.tableView endUpdates];
            
        });
        
        [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if ([[UIApplication sharedApplication] isIgnoringInteractionEvents]) {
                [[UIApplication sharedApplication] endIgnoringInteractionEvents];
            }
        });
//                                              --------------------------
        
//                                                  *** DELETE SECTIONS ***
        
    } else if (indexPath.row == lastIndex) {
        
        [self.footballLeagues removeObjectAtIndex:indexPath.section];
        
        [self.tableView beginUpdates];
        
        NSIndexSet *newIndexSet = [NSIndexSet indexSetWithIndex:indexPath.section];
        
        [self.tableView deleteSections:newIndexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView endUpdates];
    }
}
//                                              --------------------------

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath
       toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    
    NSInteger lastIndex = [[self.footballLeagues objectAtIndex:proposedDestinationIndexPath.section] count] - 1;
    
    if (proposedDestinationIndexPath.row == 0 ||
        proposedDestinationIndexPath.row == lastIndex) {
        return sourceIndexPath;
    } else {
        return proposedDestinationIndexPath;
    }
}

@end
