//
//  Doctor.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Doctor: NSObject {
    
    let name: String
    var salary: Float
    private var averagePrice: Float
    private var infliation: Float
    
// MARK: - Initialization
    
    init(name: String) {
        self.name = name
        self.salary = 500
        self.averagePrice = 10
        self.infliation = 0
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(salaryChangedNotification),
                                               name: GovernmentSalaryDidChangeNotification, object: nil)
        
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
        print("Doctor \(self.name) go to sleep")
    }
    
    func willEnterForegroundNotification(notification: Notification) {
        print("Doctor \(self.name) wakes up")
    }
    
    func salaryChangedNotification(notification: Notification) {
        
        let salary = notification.userInfo?[GovernmentSalaryUserInfoKey] as! Float
        
        print("\n\nDoctor:\nName: \(self.name)\nSalary before: \(self.salary)\nSalary now: \(salary)")
        if self.salary <= salary {
            print("Reaction: Happy. Salary is raised or similar!\n\n")
        } else {
            print("Reaction: Sad. Salary is decreased\n\n")
        }
        self.salary = salary
    }
    
    func averagePriceChangedNotification(notification: Notification) {
        
        let averagePrice = notification.userInfo?[GovernmentAveragePriceUserInfoKey] as! Float
        
        infliation = (averagePrice - self.averagePrice) / averagePrice * 100
        
        if infliation >= 0 {
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
            "Infliation: \(infliation) %")
            if infliation <= 20 {
                print("\(infliation) % is a normal situation in our world. To my mind, it's all ok\n\n")
            } else {
                print("\(infliation) %... It's very difficult situation, but people continue to get sick.. Are you ok?\n\n")
            }
        } else {
            infliation = -infliation
            print("\(self.name): Average price: \(self.averagePrice) -> \(averagePrice). ",
                "Deflation: \(infliation) %")
            if infliation <= 20 {
                print("Deflation is very nice for me. Everytime\n\n")
            } else {
                print("\(infliation) %, wtf, why did my services become cheaper?\n\n")
            }
        }
        
        self.averagePrice = averagePrice
        
    }

}
