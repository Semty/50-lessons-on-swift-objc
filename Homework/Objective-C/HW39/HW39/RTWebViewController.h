//
//  RTWebViewController.h
//  HW39
//
//  Created by Руслан on 18.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RTWebViewController : UIViewController

@property (strong, nonatomic) NSURLRequest *request;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButtonItem;

- (IBAction)actionBack:(UIBarButtonItem *)sender;
- (IBAction)actionForward:(UIBarButtonItem *)sender;
- (IBAction)actionRefresh:(UIBarButtonItem *)sender;

@end
