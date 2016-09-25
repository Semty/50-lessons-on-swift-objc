//
//  FakeAppDelegate.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class FakeAppDelegate: NSObject {
    
// MARK: - Initialization
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackgroundNotification),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishLaunchingNotification),
                                               name: NSNotification.Name.UIApplicationDidFinishLaunching, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActiveNotification),
                                               name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActiveNotification),
                                               name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willTerminateNotification),
                                               name: NSNotification.Name.UIApplicationWillTerminate, object: nil)
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
// MARK: - Notifications
    
    func didEnterBackgroundNotification(notification: Notification) {
        print("FAKE AppDelegate didEnterBackgroundNotification\n")
    }
    
    func willEnterForegroundNotification(notification: Notification) {
        print("FAKE AppDelegate willEnterForegroundNotification\n")
    }
    
    func didFinishLaunchingNotification(notification: Notification) {
        print("FAKE AppDelegate didFinishLaunchingNotification\n")
    }
    
    func willResignActiveNotification(notification: Notification) {
        print("FAKE AppDelegate willResignActiveNotification\n")
    }
    
    func didBecomeActiveNotification(notification: Notification) {
        print("FAKE AppDelegate didBecomeActiveNotification\n")
    }
    
    func willTerminateNotification(notification: Notification) {
        print("FAKE AppDelegate willTerminateNotification\n")
    }

}
