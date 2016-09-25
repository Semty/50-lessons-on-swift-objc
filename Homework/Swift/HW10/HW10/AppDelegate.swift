//
//  AppDelegate.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let government = Government()
    let doctor = Doctor(name: "Ruslan")
    let pensioner = Pensioner(name: "Eduard")
    let businessman = Businessman(name: "Akram")
    let fakeAppDelegate = FakeAppDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                                  *** LEARNER ***
        self.government.salary = 320
        self.government.pension = 120
        self.government.taxLevel = 18.5
        self.government.averagePrice = 8
        //                                                  *** STUDENT (UMNICHKA) && MASTER ***
        self.government.averagePrice = 9.2
        self.government.averagePrice = 17.6
        self.government.averagePrice = 7.8
        //                                                  *** SUPERMAN ***
        print("REAL AppDelegate didFinishLaunchingNotification")
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        print("REAL AppDelegate applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        print("REAL AppDelegate applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        print("REAL AppDelegate applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        print("REAL AppDelegate applicationDidBecomeActive")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        print("REAL AppDelegate applicationWillTerminate")
    }


}

