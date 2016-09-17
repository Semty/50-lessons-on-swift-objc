//
//  AppDelegate.swift
//  HW6
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //                                      *** 1 ***
        
        let ruslan = Human(name: "Ruslan", gender: Gender.male, direction: Direction.ahead)
        
        print("My name is \(ruslan.name). I am a \(ruslan.gender.rawValue). I am moving \(ruslan.direction.rawValue)")
        
        //                                      *** 2 && 3 ***
        
        let table = CGRectMake(0, 0, 10, 10)
        let target = CGRectMake(3, 3, 4, 4)
        
        // I am using objective-c types and methods because I don't want to write
        // similar structure (Point, Rect and Size), but I understand that it is easy)))
        
        let point1: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point2: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point3: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point4: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point5: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point6: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point7: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        let point8: CGPoint = CGPointMake(CGFloat(Int(arc4random())%10), CGFloat(Int(arc4random())%10))
        
        let points = [point1, point2, point3, point4, point5, point6, point7, point8]
        
        for (index, point) in points.enumerate() {
            if CGRectContainsPoint(table, point) && CGRectContainsPoint(target, point) {
                print("Point\(index + 1) \(point) hit in the target!",
                "(target has origin \(target.origin) and hight/width \(target.size))")
            } else {
                print("Point\(index + 1) \(point) is missed")
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

