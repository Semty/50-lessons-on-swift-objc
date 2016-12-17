//
//  ViewController.m
//  WebViewTest
//
//  Created by Руслан on 17.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    NSString *urlString = @"https://vk.com/iosdevcourse";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
     */
    /*
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"pdf"];
    
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    
    [self.webView loadData:fileData
                  MIMEType:@"application/pdf"
          textEncodingName:@"UTF-8"
                   baseURL:nil];
     
    
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:fileUrl];
    
    [self.webView loadRequest:request];
     */
    
    NSString *htmlString = @" <html>"
                            " <head> "
                            " <p style=\"font-size: 500%%; text-align: center\"> "
                            //" <a href=\"https://vk.com/iosdevcourse\">"
                            " <a href=\"cmd:show_alert\">"
                            " iOS Dev Course"
                            " </a>"
                            " Hello, World! "
                            " </p> "
                            " </head>"
                            "<body> "
                            " <p style=\"font-size: 300%%; text-align: center\"> "
                            " WTF is THIS ? "
                            " </p> "
                            " </body>"
                            " </html>";
    
    [self.webView loadHTMLString:htmlString baseURL:nil];
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

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    NSLog(@"shouldStartLoadWithRequest: %@", [request debugDescription]);
    
    NSString *urlString = [[request URL] absoluteString];
    
    if ([urlString isEqualToString:@"cmd:show_alert"]) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Alert"
                                                                                 message:@"Some Information"
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
        [alertController addAction:actionOK];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewDidStartLoad");
    
    [self.indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    
    [self.indicator stopAnimating];
    [self backAndForwardButtonsIsEnabled];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError: %@", [error localizedDescription]);
    
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







