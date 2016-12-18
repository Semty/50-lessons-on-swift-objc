//
//  WebViewController.swift
//  HW39
//
//  Created by Руслан on 18.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
// MARK: IBOutlet's variables
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var backButtonItem: UIBarButtonItem!
    @IBOutlet weak var forwardButtonItem: UIBarButtonItem!
    
    
// MARK: - Public variables
    
    var request: URLRequest!
  
// MARK: - Loading of the Programm

    override func viewDidLoad() {
        super.viewDidLoad()

        if request != nil {
            self.webView.loadRequest(request)
        }
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(backAndForwardButtonsIsEnabled),
                                               name: NSNotification.Name(rawValue: "WebHistoryItemChangedNotification"),
                                               object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Helpful Functions
    
    func backAndForwardButtonsIsEnabled() {
        
        self.backButtonItem.isEnabled = self.webView.canGoBack
        self.forwardButtonItem.isEnabled = self.webView.canGoForward
    }
    
// MARK: - UIWebViewDelegate
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest,
                 navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        indicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
        backAndForwardButtonsIsEnabled()
        
        self.navigationItem.title = self.webView.request?.url?.relativeString
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        indicator.stopAnimating()
        backAndForwardButtonsIsEnabled()
        
        let alertController = UIAlertController(title: "Error",
                                                message: error.localizedDescription,
                                                preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "OK",
                                     style: .cancel,
                                     handler: nil)
        
        alertController.addAction(actionOK)
        self.present(alertController, animated: true, completion: nil)
        self.webView.stopLoading()
    }
    
// MARK: - Actions
    
    @IBAction func actionBack(_ sender: UIBarButtonItem) {
        if self.webView.canGoBack {
            self.webView.stopLoading()
            self.webView.goBack()
        }
    }
    
    @IBAction func actionForward(_ sender: UIBarButtonItem) {
        if self.webView.canGoForward {
            self.webView.stopLoading()
            self.webView.goForward()
        }
    }
    
    @IBAction func actionRefresh(_ sender: UIBarButtonItem) {
        self.webView.stopLoading()
        self.webView.reload()
    }
}
