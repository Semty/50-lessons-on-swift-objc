//
//  Businessman.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Businessman: NSObject {
    
    let name: String
    var taxLevel: Float
    private var averagePrice: Float
    private var infliation: Float
    
// MARK: - Initialization
    
    init(name: String) {
        self.name = name
        self.taxLevel = 13
        self.averagePrice = 10
        self.infliation = 0
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(taxLevelChangedNotification),
                                               name: GovernmentTaxLevelDidChangeNotification, object: nil)
        
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
        print("Businessman \(self.name) go to sleep")
    }
    
    func willEnterForegroundNotification(notification: Notification) {
        print("Businessman \(self.name) wakes up")
    }
    
    func taxLevelChangedNotification(notification: Notification) {
        
        let taxLevel = notification.userInfo?[GovernmentTaxLevelUserInfoKey] as! Float
        
        print("\n\nBusinessman:\nName: \(self.name)\nTax Level before: \(self.taxLevel)\nTax Level now: \(taxLevel)")
        if self.taxLevel >= taxLevel {
            print("Reaction: Happy. Tax Level is decreased or similar!\n\n")
        } else {
            print("Reaction: Sad. Tax Level is raised\n\n")
        }
        self.taxLevel = taxLevel
    }
    
    func averagePriceChangedNotification(notification: Notification) {
        
        let averagePrice = notification.userInfo?[GovernmentAveragePriceUserInfoKey] as! Float
        
        infliation = (averagePrice - self.averagePrice) / averagePrice * 100
        
        if infliation >= 0 {
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
                "Infliation: \(infliation) %")
            if infliation >= 20 {
                print("\(infliation) % it's too hard for me...\n\n\n\n\n")
            } else {
                print("\(infliation) %.. I suppose, I'll can overcome it\n\n\n\n\n")
            }
        } else {
            infliation = -infliation
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
                "Deflation: \(infliation) %")
            if infliation <= 20 {
                print("Situation with \(infliation) % deflation's is very convinient for me\n\n\n\n\n")
            } else {
                print("Fuck! \(infliation) % it's a hell! My goods become cheaper!\n\n\n\n\n")
            }
        }
        
        self.averagePrice = averagePrice
        
    }

}
