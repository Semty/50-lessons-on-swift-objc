//
//  Student.swift
//  HW30
//
//  Created by Руслан on 06.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Student: NSObject {
    
// MARK: - Properties
    
    var firstName = ""
    var lastName = ""
    
    var fullName: String {
        return lastName + " " + firstName
    }
    
    var averageMark: Double = 0
    
// MARK: - Initialization
    
    override init() {
        
        super.init()
        
        self.firstName = randomFirstName()
        self.lastName = randomLastName()
        self.averageMark = randomAverageMark()
        
    }
    
// MARK: - Helpful Functions
    
    func randomFirstName() -> String {
        
        let randomFirstName = arc4random() % 11
        
        switch randomFirstName {
        case 0:
            return "Ruslan"
        case 1:
            return "Akram"
        case 2:
            return "Zahar"
        case 3:
            return "Sveta"
        case 4:
            return "Dasha"
        case 5:
            return "Sergey"
        case 6:
            return "Igor"
        case 7:
            return "Natasha"
        case 8:
            return "Marina"
        case 9:
            return "Misha"
        case 10:
            return "Grisha"
        default:
            return "Default"
        }
    }
    
    func randomLastName() -> String {
        
        let randomLastName = arc4random() % 11
        
        switch randomLastName {
        case 0:
            return "Timchenko"
        case 1:
            return "Makhmudov(a)"
        case 2:
            return "Ostapenko"
        case 3:
            return "Shilov(a)"
        case 4:
            return "Minkh"
        case 5:
            return "Trusov(a)"
        case 6:
            return "Kin"
        case 7:
            return "Monorov(a)"
        case 8:
            return "Trebov(a)"
        case 9:
            return "Padavannov(a)"
        case 10:
            return "Amov(a)"
        default:
            return "Default"
        }
    }
    
    func randomAverageMark() -> Double {
        
        return ((Double)(arc4random() % 30) + 20) / 10.0
        
    }

}
