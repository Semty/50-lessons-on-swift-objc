//
//  RTTableViewController.m
//  HW39
//
//  Created by Руслан on 18.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTTableViewController.h"
#import "RTWebViewController.h"

typedef enum {
    
    pdfSection,
    webSection
    
} Sections;

typedef enum {
    
    tablePDFRow,
    reitzPDFRow,
    BergerPDFRow
    
} pdfRows;

typedef enum {
    
    iosDevCourseWebRow,
    youtubeWebRow,
    appleWebRow
    
} webRows;

@interface RTTableViewController ()

@property (strong, nonatomic) NSURL *url;

@end

@implementation RTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *urlString;
    
    switch (indexPath.section) {
            
        case pdfSection:
            
            switch (indexPath.row) {
                    
                case tablePDFRow:
                    urlString = [[NSBundle mainBundle] pathForResource:@"pdf_1" ofType:@"pdf"];
                    self.url = [NSURL fileURLWithPath:urlString];
                    break;
                case reitzPDFRow:
                    urlString = [[NSBundle mainBundle] pathForResource:@"pdf_2" ofType:@"pdf"];
                    self.url = [NSURL fileURLWithPath:urlString];
                    break;
                case BergerPDFRow:
                    urlString = [[NSBundle mainBundle] pathForResource:@"pdf_3" ofType:@"pdf"];
                    self.url = [NSURL fileURLWithPath:urlString];
                    break;
            }
            break;
            
        case webSection:
            
            switch (indexPath.row) {
                    
                case iosDevCourseWebRow:
                    urlString = @"https://vk.com/iosdevcourse";
                    self.url = [NSURL URLWithString:urlString];
                    break;
                case youtubeWebRow:
                    urlString = @"https://youtube.com";
                    self.url = [NSURL URLWithString:urlString];
                    break;
                case appleWebRow:
                    urlString = @"https://apple.com";
                    self.url = [NSURL URLWithString:urlString];
                    break;
            }
            break;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    
    RTWebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"RTWebViewController"];
    vc.request = request;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end





