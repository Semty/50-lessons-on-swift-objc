//
//  Government.swift
//  HW10
//
//  Created by Руслан on 25.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

let GovernmentTaxLevelDidChangeNotification = Notification.Name(rawValue: "GovernmentTaxLevelDidChangeNotification")
let GovernmentSalaryDidChangeNotification = Notification.Name(rawValue: "GovernmentSalaryDidChangeNotification")
let GovernmentPensionDidChangeNotification = Notification.Name(rawValue: "GovernmentPensionDidChangeNotification")
let GovernmentAveragePriceDidChangeNotification = Notification.Name(rawValue: "GovernmentAveragePriceDidChangeNotification")


let GovernmentTaxLevelUserInfoKey = "GovernmentTaxLevelUserInfoKey"
let GovernmentSalaryUserInfoKey = "GovernmentSalaryUserInfoKey"
let GovernmentPensionUserInfoKey = "GovernmentPensionUserInfoKey"
let GovernmentAveragePriceUserInfoKey = "GovernmentAveragePriceUserInfoKey"

class Government: NSObject {
    
// MARK: - Properties and Notifications
    
    var taxLevel: Float {
        didSet {
            let taxLevelDictionary = [GovernmentTaxLevelUserInfoKey: taxLevel]
            
            NotificationCenter.default.post(name: GovernmentTaxLevelDidChangeNotification,
                                            object: nil,
                                            userInfo: taxLevelDictionary)
        }
    }
    var salary: Float {
        didSet {
            let salaryDictionary = [GovernmentSalaryUserInfoKey: salary]
            
            NotificationCenter.default.post(name: GovernmentSalaryDidChangeNotification,
                                            object: nil,
                                            userInfo: salaryDictionary)
        }
    }
    var pension: Float {
        didSet {
            let pensionDictionary = [GovernmentPensionUserInfoKey: pension]
            
            NotificationCenter.default.post(name: GovernmentPensionDidChangeNotification,
                                            object: nil,
                                            userInfo: pensionDictionary)
        }
    }
    var averagePrice: Float {
        didSet {
            let averagePriceDictionary = [GovernmentAveragePriceUserInfoKey: averagePrice]
            
            NotificationCenter.default.post(name: GovernmentAveragePriceDidChangeNotification,
                                            object: nil,
                                            userInfo: averagePriceDictionary)
        }
    }
    
// MARK: - Initialization
    
    override init() {
        self.taxLevel = 13
        self.salary = 500
        self.pension = 200
        self.averagePrice = 10
        super.init()
        
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
        print("Government goes to sleep")
    }
    
    func willEnterForegroundNotification(notification: Notification) {
        print("Government wakes up")
    }


}
