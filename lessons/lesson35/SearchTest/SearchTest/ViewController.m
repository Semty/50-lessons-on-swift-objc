//
//  ViewController.m
//  SearchTest
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "NSString+Random.h"
#import "RTSection.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray *namesArray;
@property (strong, nonatomic) NSArray *sectionsArray;
@property (strong, nonatomic) NSOperation *currentOperation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 1000000; i++) {
        [array addObject:[[NSString randomAlphanumericString] capitalizedString]];
    }
    
    NSArray *tempArray = [array sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    
    self.namesArray = tempArray;
    
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:self.searchBar.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful functions

- (void) generateSectionsInBackgroundFromArray:(NSArray *)array withFilter:(NSString *)filter {
    
    [self.currentOperation cancel];
    
    __weak ViewController *weakSelf = self;
    
    self.currentOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSArray *sectionsArray = [weakSelf generateSectionsFromArray:array withFilter:filter];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sectionsArray = sectionsArray;
            [weakSelf.tableView reloadData];
            
            self.currentOperation = nil;
        });
    }];
    
    NSOperationQueue *currentQueue = [[NSOperationQueue alloc] init];
    [currentQueue addOperation:self.currentOperation];
}

- (NSArray *) generateSectionsFromArray:(NSArray *)array withFilter:(NSString *)filter {
    
    NSMutableArray *sectionsArray = [[NSMutableArray alloc] init];
    NSString *currentLetter = nil;
    
    for (NSString *string in array) {
        
        if ([filter length] > 0 && [string rangeOfString:filter].location == NSNotFound) {
            continue;
        }
        
        NSString *firstLetter = [string substringToIndex:1];
        
        RTSection *section = nil;
        
        if (![firstLetter isEqualToString:currentLetter]) {
            
            section = [[RTSection alloc] init];
            section.sectionName = firstLetter;
            section.itemsArray = [[NSMutableArray alloc] init];
            currentLetter = firstLetter;
            [sectionsArray addObject:section];
        } else {
            section = [sectionsArray lastObject];
        }
        
        [section.itemsArray addObject:string];
    }
    
    return sectionsArray;
}

#pragma mark - UITableViewDataSource

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (RTSection *section in self.sectionsArray) {
        [array addObject:section.sectionName];
    }
    return array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sectionsArray count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[self.sectionsArray objectAtIndex:section] sectionName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.sectionsArray objectAtIndex:section] itemsArray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                      
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [[[self.sectionsArray objectAtIndex:indexPath.section]
                            itemsArray] objectAtIndex:indexPath.row];
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {

    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [self generateSectionsInBackgroundFromArray:self.namesArray withFilter:searchText];
}

@end









