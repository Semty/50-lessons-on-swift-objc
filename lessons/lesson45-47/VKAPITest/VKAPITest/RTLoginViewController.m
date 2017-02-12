//
//  RTLoginViewController.m
//  VKAPITest
//
//  Created by Руслан on 12.02.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

#import "RTLoginViewController.h"
#import "RTAccessToken.h"

@interface RTLoginViewController () <UIWebViewDelegate>

@property (copy, nonatomic) RTLoginComplitionBlock complitionBlock;
@property (weak, nonatomic) UIWebView *webView;

@end

@implementation RTLoginViewController

- (instancetype)initWithComplitionBlock:(RTLoginComplitionBlock)complitionBlock
{
    self = [super init];
    if (self) {
        
        self.complitionBlock = complitionBlock;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect rect = self.view.bounds;
    rect.origin = CGPointZero;
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:rect];
    webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:webView];
    
    UIBarButtonItem *itemCancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(actionCancel:)];
    [self.navigationItem setRightBarButtonItem:itemCancel animated:YES];
    
    self.navigationItem.title = @"Login";
    
    NSString *urlString = @"https://oauth.vk.com/authorize?"
                          "client_id=5871524&"
                          "redirect_uri=hello.there&"
                          "display=mobile&"
                          "scope=139286&"
                          "response_type=token&"
                          "v=5.62";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    self.webView = webView;
    
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc {
    self.webView = nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Actions

- (void) actionCancel:(UIBarButtonItem *)itemCancel {
    
    if (self.complitionBlock) {
        self.complitionBlock(nil);
    }
    
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView    shouldStartLoadWithRequest:(NSURLRequest *)request
                                                    navigationType:(UIWebViewNavigationType)navigationType {
    
    // http://hello.there/#access_token=fd104dc2598e9f8ee806c0ce92930c2e4873635854248fd120378b907612acb7c7928ecaecd2c849d294a&expires_in=86400&user_id=177780397
    
    if ([[[request URL] host] isEqualToString:@"hello.there"]) {
        
        RTAccessToken *token = [[RTAccessToken alloc] init];
        
        NSString *query = [[request URL] description];
        
        NSArray *array = [query componentsSeparatedByString:@"#"];
        
        if ([array count] > 1) {
            query = [array lastObject];
        }
        
        NSArray *pairs = [query componentsSeparatedByString:@"&"];
        
        for (NSString *pair in pairs) {
            
            NSArray *values = [pair componentsSeparatedByString:@"="];
            
            if ([values count] == 2) {
                
                NSString *key = [values firstObject];
                
                if ([key isEqualToString:@"access_token"]) {
                    
                    token.accessToken = [values lastObject];
                    
                } else if ([key isEqualToString:@"expires_in"]) {
                    
                    NSTimeInterval interval = [[values lastObject] doubleValue];
                    
                    token.expiresDate = [NSDate dateWithTimeIntervalSinceNow:interval];
                    
                } else if ([key isEqualToString:@"user_id"]) {
                    
                    token.userID = [values lastObject];
                }
            }
            
        }
        
        if (self.complitionBlock) {
            self.complitionBlock(token);
        }
        
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
    
    return YES;
}

@end









