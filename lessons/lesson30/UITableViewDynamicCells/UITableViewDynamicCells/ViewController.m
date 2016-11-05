//
//  ViewController.m
//  UITableViewDynamicCells
//
//  Created by Руслан on 04.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSLog(@"numberOfSectionsInTableView");
    
    return [[UIFont familyNames] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSLog(@"numberOfRowsInSection %ld", section);
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSString *currentName = [familyNames objectAtIndex:section];
    
    return [[UIFont fontNamesForFamilyName:currentName] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return [[UIFont familyNames] objectAtIndex:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"cellForRowAtIndexPath {%ld, %ld}", indexPath.section, indexPath.row);
    
    static NSString *identifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSLog(@"Cell is created");
    } else {
        NSLog(@"Cell is reused");
    }
    
    NSArray *familyNames = [UIFont familyNames];
    
    NSString *currentName = [familyNames objectAtIndex:indexPath.section];
    
    NSString *fontName = [[UIFont fontNamesForFamilyName:currentName] objectAtIndex:indexPath.row];
    
    UIFont *font = [UIFont fontWithName:fontName size:16];
    
    cell.textLabel.font = font;
    cell.textLabel.text = fontName;
    
    return cell;
}

@end










