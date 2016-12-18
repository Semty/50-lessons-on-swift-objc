//
//  RTWebViewController.m
//  HW39
//
//  Created by Руслан on 18.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "RTWebViewController.h"

@interface RTWebViewController () <UIWebViewDelegate>

@end

@implementation RTWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.request) {
        [self.webView loadRequest:self.request];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backAndForwardButtonsIsEnabled)
                                                 name:@"WebHistoryItemChangedNotification"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpful Functions

- (void) backAndForwardButtonsIsEnabled {
    self.backButtonItem.enabled     = [self.webView canGoBack];
    self.forwardButtonItem.enabled  = [self.webView canGoForward];
}

/*
- (BOOL) httpTohttps:(NSString *)http {
    
    NSString *tempHttp = [http substringToIndex:4];
    NSString *tempS = [http substringWithRange:NSMakeRange(4, 1)];
    NSString *newUrlString;
    
    if (![tempS isEqualToString:@"s"] && [tempHttp isEqualToString:@"http"]) {
        
        NSString *https = [tempHttp stringByAppendingString:@"s"];
        
        newUrlString = [https stringByAppendingString:[http substringWithRange:NSMakeRange(4, [http length] - 4)]];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:newUrlString]]];
        return YES;
    }
    return NO;
}
 */

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    //NSString *urlString = [[request URL] absoluteString];
    /*
    if ([self httpTohttps:urlString]) {
        return NO;
    }
    */
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.indicator stopAnimating];
    [self backAndForwardButtonsIsEnabled];
    
    self.navigationItem.title = [self.webView.request.URL.relativeString lastPathComponent];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.indicator stopAnimating];
    [self backAndForwardButtonsIsEnabled];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                             message:[error localizedDescription]
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleCancel
                                                     handler:nil];
    [alertController addAction:actionOK];
    [self presentViewController:alertController animated:YES completion:nil];
    [self.webView stopLoading];
}

#pragma mark - Actions

- (IBAction)actionBack:(UIBarButtonItem *)sender {
    if ([self.webView canGoBack]) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction)actionForward:(UIBarButtonItem *)sender {
    if ([self.webView canGoForward]) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

- (IBAction)actionRefresh:(UIBarButtonItem *)sender {
    [self.webView stopLoading];
    [self.webView reload];
}

@end
