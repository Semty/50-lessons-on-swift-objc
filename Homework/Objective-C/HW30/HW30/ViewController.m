//
//  ViewController.m
//  HW30
//
//  Created by Руслан on 05.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"
#import "RTRandomColor.h"
#import "RTStudent.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *randomColors;
@property (strong, nonatomic) NSMutableArray *studentsSortedByNames;
@property (strong, nonatomic) NSMutableArray *studentsSortedByMarks;

@property (strong, nonatomic) NSMutableArray *studentsLowMarks;
@property (strong, nonatomic) NSMutableArray *studentsMediocreMarks;
@property (strong, nonatomic) NSMutableArray *studentsGoodMarks;
@property (strong, nonatomic) NSMutableArray *studentsExcellentMarks;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.randomColors = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        RTRandomColor *randomColor = [[RTRandomColor alloc] initWithColorAndName];
        [self.randomColors addObject:randomColor];
    }
    
    
    //self.studentsSortedByNames = [[NSMutableArray alloc] init];
    self.studentsSortedByMarks = [[NSMutableArray alloc] init];
    
    self.studentsLowMarks = [[NSMutableArray alloc] init];
    self.studentsMediocreMarks = [[NSMutableArray alloc] init];
    self.studentsGoodMarks = [[NSMutableArray alloc] init];
    self.studentsExcellentMarks = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 25; i++) {
        RTStudent *student = [[RTStudent alloc] initWithFullNameAndAvMark];
        //[self.studentsSortedByNames addObject:student];
        [self.studentsSortedByMarks addObject:student];
        
        if (student.averageMark < 2.5) {
            [self.studentsLowMarks addObject:student];
        } else if (student.averageMark < 3.5) {
            [self.studentsMediocreMarks addObject:student];
        } else if (student.averageMark < 4.5) {
            [self.studentsGoodMarks addObject:student];
        } else {
            [self.studentsExcellentMarks addObject:student];
        }
    }
    
    //self.studentsSortedByNames = [self sortArrayByNames:self.studentsSortedByNames];
    
    self.studentsLowMarks = [self sortArrayByNames:self.studentsLowMarks];
    self.studentsMediocreMarks = [self sortArrayByNames:self.studentsMediocreMarks];
    self.studentsGoodMarks = [self sortArrayByNames:self.studentsGoodMarks];
    self.studentsExcellentMarks = [self sortArrayByNames:self.studentsExcellentMarks];
    
    [self.studentsSortedByMarks sortUsingComparator:^NSComparisonResult(RTStudent *obj1, RTStudent *obj2) {
        
        if (obj1.averageMark >= obj2.averageMark) {
            return NSOrderedAscending;
        } else {
            return NSOrderedDescending;
        }
        
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful functions

- (NSMutableArray *) sortArrayByNames:(NSMutableArray *)array {
    
    [array sortUsingComparator:^NSComparisonResult(RTStudent *obj1, RTStudent *obj2) {
        
        if ([obj1.lastName isEqualToString:obj2.lastName]) {
            return [obj1.firstName compare:obj2.firstName];
        } else {
            return [obj1.lastName compare:obj2.lastName];
        }
    }];
    
    return array;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return [self.studentsLowMarks count];
            break;
        case 1:
            return [self.studentsMediocreMarks count];
            break;
        case 2:
            return [self.studentsGoodMarks count];
            break;
        case 3:
            return [self.studentsExcellentMarks count];
            break;
        case 4:
            return [self.randomColors count];
            break;
        default:
            return 0;
            break;
    }
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"Low mark students";
            break;
        case 1:
            return @"Mediocre students";
            break;
        case 2:
            return @"Good mark students";
            break;
        case 3:
            return @"Excellent mark students";
            break;
        case 4:
            return @"Colors";
            break;
        default:
            return @"Default";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *student = @"student";
    static NSString *color = @"color";
    
    UITableViewCell *cell = [[UITableViewCell alloc] init];

    if (indexPath.section == 4) {
        
        cell = [tableView dequeueReusableCellWithIdentifier:color];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:color];
        }
        
        cell.backgroundColor = ((RTRandomColor *)[self.randomColors objectAtIndex:indexPath.row]).color;
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.shadowColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = ((RTRandomColor *)[self.randomColors objectAtIndex:indexPath.row]).name;
        
    } else {
        
        cell = [tableView dequeueReusableCellWithIdentifier:student];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:student];
        }
        
        RTStudent *student = [[RTStudent alloc] init];
        
        switch (indexPath.section) {
            case 0:
                student = [self.studentsLowMarks objectAtIndex:indexPath.row];
                cell.textLabel.textColor = [UIColor redColor];
                break;
            case 1:
                student = [self.studentsMediocreMarks objectAtIndex:indexPath.row];
                cell.textLabel.textColor = [UIColor orangeColor];
                break;
            case 2:
                student = [self.studentsGoodMarks objectAtIndex:indexPath.row];
                cell.textLabel.textColor = [UIColor magentaColor];
                break;
            case 3:
                student = [self.studentsExcellentMarks objectAtIndex:indexPath.row];
                cell.textLabel.textColor = [UIColor greenColor];
                break;
            default:
                break;
        }
        
        
        cell.textLabel.text = student.fullName;
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%1.1f", student.averageMark];
    }
    
    /*
    CGFloat r = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat g = (CGFloat)(arc4random() % 256) / 255.f;
    CGFloat b = (CGFloat)(arc4random() % 256) / 255.f;
    
    cell.backgroundColor = [UIColor colorWithRed:r green:g blue:b alpha:1.f];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. RGB(%d, %d, %d)",
                           indexPath.row, (int)(r * 255), (int)(g * 255), (int)(b * 255)];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    */
    /*
    cell.backgroundColor = ((RTRandomColor *)[self.randomColors objectAtIndex:indexPath.row]).color;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.shadowColor = [UIColor blackColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = ((RTRandomColor *)[self.randomColors objectAtIndex:indexPath.row]).name;
    */

    return cell;
}


@end
