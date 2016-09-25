//
//  Pensioner.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Pensioner: NSObject {
    
    let name: String
    var pension: Float
    private var averagePrice: Float
    private var infliation: Float
    
// MARK: - Initialization
    
    init(name: String) {
        self.name = name
        self.pension = 200
        self.averagePrice = 10
        self.infliation = 0
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(pensionChangedNotification),
                                               name: GovernmentPensionDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(averagePriceChangedNotification),
                                               name: GovernmentAveragePriceDidChangeNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didEnterBackgroundNotification),
                                               name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willEnterForegroundNotification),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
// MARK: - Notifications
    
    func didEnterBackgroundNotification(notification: Notification) {
        print("Pensioner \(self.name) go to sleep")
    }
    
    func willEnterForegroundNotification(notification: Notification) {
        print("Pensioner \(self.name) wakes up")
    }
    
    func pensionChangedNotification(notification: Notification) {
        
        let pension = notification.userInfo?[GovernmentPensionUserInfoKey] as! Float
        
        print("\n\nPensioner:\nName: \(self.name)\nPension before: \(self.pension)\nPension now: \(pension)")
        if self.pension <= pension {
            print("Reaction: Happy. Pension is raised or similar!\n\n")
        } else {
            print("Reaction: Sad. Pension is decreased\n\n")
        }
        self.pension = pension
    }
    
    func averagePriceChangedNotification(notification: Notification) {
        
        let averagePrice = notification.userInfo?[GovernmentAveragePriceUserInfoKey] as! Float
        
        infliation = (averagePrice - self.averagePrice) / averagePrice * 100
        
        if infliation >= 0 {
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
                "Infliation: \(infliation) %")
            if infliation <= 20 {
                print("I think that infiation with level on \(infliation) % doesn't kill me..\n\n")
            } else {
                print("\(infliation) %! Oh my God!! How should I live?!\n\n")
            }
        } else {
            infliation = -infliation
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
                "Deflation: \(infliation) %")
            if infliation <= 20 {
                print("I see a low level of deflation ( <= 20 ). Nevermind, it is good))\n\n")
            } else {
                print("RUSH A SHOP! WHERE ARE MY POTATOES??!\n\n")
            }
        }
        
        self.averagePrice = averagePrice
        
    }
    
}
