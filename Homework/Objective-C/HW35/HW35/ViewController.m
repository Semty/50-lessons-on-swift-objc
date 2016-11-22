//
//  ViewController.m
//  HW35
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTUserCell.h"
#import "RTMan.h"
#import "RTSection.h"

@interface ViewController ()

@property (assign, nonatomic) BOOL isHide;
@property (strong, nonatomic) NSArray *people;
@property (strong, nonatomic) NSArray *sections;
@property (strong, nonatomic) NSOperation *currentOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isHide = NO;
    
    self.people = [RTMan randomPeopleWithNumber:2500];
    
    [self sortingAction:self.sortingControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful functions

- (NSInteger) countPeopleFromArray:(NSArray *)array {
    
    NSInteger count = 0;
    
    for (RTSection *section in array) {
        count += [[section itemsArray] count];
    }
    return count;
}

- (NSString *) formatStringFromDate:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd MMM, yyyy"];
    
    return [formatter stringFromDate:date];
}

- (NSString *) shortMonthFromBirth:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    
    return [formatter stringFromDate:date];
}

- (NSString *) longMonthFromBirth:(NSDate *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    
    return [formatter stringFromDate:date];
}

#pragma mark - Generation

- (void) generateSectionsInBackgroungFromArray:(NSArray *)array withFilter:(NSString *)filter {
    
    [self.currentOperation cancel];
    
    __weak ViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSArray *sections = [weakSelf generateSectionsFromArray:array withFilter:filter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
           
            weakSelf.sections = sections;
            [weakSelf.tableView reloadData];
            
            self.currentOperation = nil;
            if (!self.isHide) {
                self.navigationItem.prompt = [NSString stringWithFormat:@"In Search: %ld person(s)",
                                              [weakSelf countPeopleFromArray:weakSelf.sections]];
            }
        });
    }];
    
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [operationQueue addOperation:self.currentOperation];
}

- (NSArray *) generateSectionsFromArray:(NSArray *)array withFilter:(NSString *)filter {
    
    NSMutableArray *sections = [[NSMutableArray alloc] init];
    
    NSString *currentMonth = nil;
    NSString *currentLetter = nil;
    
    switch (self.sortingControl.selectedSegmentIndex) {
        case RTMonth:
            
            for (RTMan *man in array) {
                
                NSString *fullName = [NSString stringWithFormat:@"%@ %@", man.firstName, man.lastName];
                
                if ([filter length] > 0 && [fullName rangeOfString:filter].location == NSNotFound) {
                    continue;
                }
                
                NSString *month = [self longMonthFromBirth:man.birthday];
                
                RTSection *section = nil;
                
                if (![currentMonth isEqualToString:month]) {
                    
                    section = [[RTSection alloc] init];
                    section.sectionName = [self shortMonthFromBirth:man.birthday];
                    section.itemsArray = [[NSMutableArray alloc] init];
                    currentMonth = month;
                    [sections addObject:section];
                    
                } else {
                    
                    section = [sections lastObject];
                }
                [section.itemsArray addObject:man];
            }
            
            return sections;
            
        case RTFirstName:
            
            for (RTMan *man in array) {
                
                NSString *fullName = man.firstName;
                
                if ([filter length] > 0 && [fullName rangeOfString:filter].location == NSNotFound) {
                    continue;
                }
                
                NSString *firstLetter = [man.firstName substringToIndex:1];
                
                RTSection *section = nil;
                
                if (![currentLetter isEqualToString:firstLetter]) {
                    
                    section = [[RTSection alloc] init];
                    section.sectionName = firstLetter;
                    section.itemsArray = [[NSMutableArray alloc] init];
                    currentLetter = firstLetter;
                    [sections addObject:section];
                    
                } else {
                    
                    section = [sections lastObject];
                }
                [section.itemsArray addObject:man];
            }
            
            return sections;
            
        case RTLastName:
            
            for (RTMan *man in array) {
                
                NSString *fullName = man.lastName;
                
                if ([filter length] > 0 && [fullName rangeOfString:filter].location == NSNotFound) {
                    continue;
                }
                
                NSString *firstLetter = [man.lastName substringToIndex:1];
                
                RTSection *section = nil;
                
                if (![currentLetter isEqualToString:firstLetter]) {
                    
                    section = [[RTSection alloc] init];
                    section.sectionName = firstLetter;
                    section.itemsArray = [[NSMutableArray alloc] init];
                    currentLetter = firstLetter;
                    [sections addObject:section];
                    
                } else {
                    
                    section = [sections lastObject];
                }
                [section.itemsArray addObject:man];
            }
            
            return sections;
        default:
            break;
    }
    return [[NSArray alloc] init]; // default :)
}

#pragma mark - Sorting

- (NSArray *) sortedUsingMonth:(NSArray *)array {
    
    NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(RTMan *obj1, RTMan *obj2) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM"];
        
        NSString *date1 = [formatter stringFromDate:obj1.birthday];
        NSString *date2 = [formatter stringFromDate:obj2.birthday];
        
        return [date1 compare:date2];
    }];
    return sortedArray;
}

- (NSArray *) sortedUsingFullName:(NSArray *)array withNamePriority:(BOOL)name {
    
    if (name) {
        
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(RTMan *obj1, RTMan *obj2) {
            
            if ([obj1.firstName isEqualToString:obj2.firstName]) {
                return [obj1.lastName compare:obj2.lastName];
            } else {
                return [obj1.firstName compare:obj2.firstName];
            }
            
        }];
        return sortedArray;
    } else {
        NSArray *sortedArray = [array sortedArrayUsingComparator:^NSComparisonResult(RTMan *obj1, RTMan *obj2) {
            
            if ([obj1.lastName isEqualToString:obj2.lastName]) {
                return [obj1.firstName compare:obj2.firstName];
            } else {
                return [obj1.lastName compare:obj2.lastName];
            }
            
        }];
        return sortedArray;
    }
    
}

#pragma mark - UITableViewDataSource

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *sectionNames = [[NSMutableArray alloc] init];
    
    for (RTSection *section in self.sections) {
        [sectionNames addObject:section.sectionName];
    }
    return sectionNames;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[[self.sections objectAtIndex:section] itemsArray] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    RTMan *man = [[[self.sections objectAtIndex:section] itemsArray] objectAtIndex:0];
    
    NSString *month = [self longMonthFromBirth:man.birthday];
    
    switch (self.sortingControl.selectedSegmentIndex) {
        case RTMonth:
            
            return [NSString stringWithFormat:@"%@ - %ld person(s)",
                    month, [[[self.sections objectAtIndex:section] itemsArray] count]];
        default:
            return [NSString stringWithFormat:@"%@ - %ld person(s)",
                    [[self.sections objectAtIndex: section] sectionName],
                    [[[self.sections objectAtIndex:section] itemsArray] count]];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    RTUserCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    RTMan *man = [[[self.sections objectAtIndex:indexPath.section] itemsArray] objectAtIndex:indexPath.row];
    
    cell.fullname.text = [NSString stringWithFormat:@"%@ %@", man.firstName, man.lastName];
    cell.dateOfBirth.text = [self formatStringFromDate:man.birthday];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [searchBar resignFirstResponder];
    });
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self generateSectionsInBackgroungFromArray:self.people withFilter:searchText];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar setShowsCancelButton:NO animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.18 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [searchBar resignFirstResponder];
    });
}

#pragma mark - Actions

- (IBAction)hideShowAction:(UIBarButtonItem *)sender {
    
    if ([sender.title isEqualToString:@"Hide"]) {
        self.isHide = YES;
        sender.title = @"Show";
        self.navigationItem.prompt = nil;
    } else {
        self.isHide = NO;
        sender.title = @"Hide";
        self.navigationItem.prompt = [NSString stringWithFormat:@"In Search: %ld person(s)",
                                      [self countPeopleFromArray:self.sections]];
    }
}

- (IBAction)sortingAction:(UISegmentedControl *)sender {
    
    switch (self.sortingControl.selectedSegmentIndex) {
        case RTMonth:
            
            self.people = [self sortedUsingFullName:self.people withNamePriority:YES];
            self.people = [self sortedUsingMonth:self.people];
            
            [self generateSectionsInBackgroungFromArray:self.people withFilter:self.searchBar.text];
            self.searchBar.placeholder = @"Type FirstName or LastName";
            break;
        case RTFirstName:
            
            self.people = [self sortedUsingMonth:self.people];
            self.people = [self sortedUsingFullName:self.people withNamePriority:YES];
            
            [self generateSectionsInBackgroungFromArray:self.people withFilter:self.searchBar.text];
            self.searchBar.placeholder = @"Type FirstName";
            break;
        case RTLastName:
            
            self.people = [self sortedUsingMonth:self.people];
            self.people = [self sortedUsingFullName:self.people withNamePriority:NO];
            
            [self generateSectionsInBackgroungFromArray:self.people withFilter:self.searchBar.text];
            self.searchBar.placeholder = @"Type LastName";
            break;
        default:
            break;
    }
    
}

@end
