//
//  Student.swift
//  HW16
//
//  Created by Руслан on 09.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Student {
    
    var name = ""
    var surname = ""
    let alias: String
    var dateOfBirth = Date.init(timeIntervalSince1970: 0) // default date of birth

    init(alias: String) {
        self.alias = alias
        self.name = createName()
        self.surname = createSurname()
        self.dateOfBirth = createDateOfBirth()
    }
    
    func createName() -> String {
        
        let code = arc4random() % 15
        
        switch code {
        case 0:
            return "Jack"
        case 1:
            return "Mariya"
        case 2:
            return "Alex"
        case 3:
            return "Ruslan"
        case 4:
            return "Eduard"
        case 5:
            return "Erik"
        case 6:
            return "Misha"
        case 7:
            return "Akram"
        case 8:
            return "Zahar"
        case 9:
            return "Dasha"
        case 10:
            return "Ann"
        case 11:
            return "Svetlana"
        case 12:
            return "Gleb"
        case 13:
            return "Dan"
        case 14:
            return "Nastya"
        default: return ""
        }
    }
    
    func createSurname() -> String {
        
        let code = arc4random() % 15
        
        switch code {
        case 0:
            return "Timchenko"
        case 1:
            return "Makhmudov(a)"
        case 2:
            return "Nugamanov(a)"
        case 3:
            return "Smith"
        case 4:
            return "Blazhic"
        case 5:
            return "Contana"
        case 6:
            return "Tarasov(a)"
        case 7:
            return "Maksimenko"
        case 8:
            return "Gregorovich"
        case 9:
            return "Stock"
        case 10:
            return "Menex"
        case 11:
            return "Kolomov(a)"
        case 12:
            return "Evtushenko"
        case 13:
            return "Kobilkin(a)"
        case 14:
            return "Black"
        default: return ""
        }
    }

    func createDateOfBirth() -> Date {
        
        let randomNumber = Double((arc4random() % 1072224000) + 504576000) // it is age between 16 and 50
        
        let myFormatter = DateFormatter()
        myFormatter.dateFormat = "dd.MM.yyyy"
        let startDate = myFormatter.date(from: "11.01.2016")!
        
        let randomDate = Date.init(timeInterval: -randomNumber, since: startDate)
        return randomDate
    }
    
}
