//
//  ViewController.h
//  HW35
//
//  Created by Руслан on 21.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    RTMonth,
    RTFirstName,
    RTLastName
    
}RTSorting;

@interface ViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortingControl;

- (IBAction)hideShowAction:(UIBarButtonItem *)sender;
- (IBAction)sortingAction:(UISegmentedControl *)sender;

@end

