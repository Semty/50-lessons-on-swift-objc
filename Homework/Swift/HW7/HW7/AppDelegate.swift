//
//  AppDelegate.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        let runner = Runner(name: "Ruslan")
        let swimmer = Swimmer(name: "Eduard")
        let jumper = Jumper(name: "Akram")
        let kangaroo = Kangaroo(name: "Sharik")
        let loafer = Loafer(name: "Zahar")
        
        let objects: [AnyObject] = [runner, swimmer, jumper, kangaroo, loafer]
        
        for object in objects {
            if let tempLoafer = object as? Loafer {
                print("\(tempLoafer.name) IS A LOAFER!!!")
            }
            if let tempRunner = object as? Runners {
                print("\(tempRunner.run())\n\(tempRunner.laugh())")
            }
            if let tempJumper = object as? Jumpers {
                print("\(tempJumper.jump())\n\(tempJumper.laugh())")
            }
            if let tempSwimmer = object as? Swimmers {
                print("\(tempSwimmer.swim())")
            }
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

