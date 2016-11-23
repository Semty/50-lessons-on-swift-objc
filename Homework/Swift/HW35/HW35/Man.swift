//
//  Man.swift
//  HW35
//
//  Created by Руслан on 23.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Man: NSObject {
    
// MARK: - Public variables
    
    var firstName = ""
    var lastName = ""
    var birthday = Date()
    
// MARK: - Private static variables
    
    private static let firstNames = ["Tran", "Lenore", "Bud", "Fredda", "Katrice",
                    "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert",
                    "Billie", "Tamica", "Crystle", "Kandi", "Caridad",
                    "Vanetta", "Taylor", "Pinkie", "Ben", "Rosanna",
                    "Eufemia", "Britteny", "Ramon", "Jacque", "Telma",
                    "Colton", "Monte", "Pam", "Tracy", "Tresa",
                    "Willard", "Mireille", "Roma", "Elise", "Trang",
                    "Ty", "Pierre", "Floyd", "Savanna", "Arvilla",
                    "Whitney", "Denver", "Norbert", "Meghan", "Tandra",
                    "Jenise", "Brent", "Elenor", "Sha", "Jessie", "Akram",
                    "Ruslan", "Dasha", "Sergey", "Sveta", "Zahar"]
    
    private static let lastNames = ["Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
                    "Homan", "Starns", "Oldham", "Yocum", "Mancia",
                    "Prill", "Lush", "Piedra", "Castenada", "Warnock",
                    "Vanderlinden", "Simms", "Gilroy", "Brann", "Bodden",
                    "Lenz", "Gildersleeve", "Wimbish", "Bello", "Beachy",
                    "Jurado", "William", "Beaupre", "Dyal", "Doiron",
                    "Plourde", "Bator", "Krause", "Odriscoll", "Corby",
                    "Waltman", "Michaud", "Kobayashi", "Sherrick", "Woolfolk",
                    "Holladay", "Hornback", "Moler", "Bowles", "Libbey",
                    "Spano", "Folson", "Arguelles", "Burke", "Rook", "Timchenko",
                    "Makhmudov(a)", "Astapenkov(a)", "Kobilkin(a)", "Tarasov(a)",
                    "Glushko"]
    
// MARK: - Private class functions
    
    private class func randomMan() -> Man {
        
        let man = Man()
        
        let plusOrMinus = arc4random() % 2 == 1 ? 1 : -1
        
        let birthday = Date(timeIntervalSince1970:
            (TimeInterval)((Int)(arc4random() % 1450656000) * plusOrMinus))
        
        man.firstName = firstNames[(Int)(arc4random() % (UInt32)(firstNames.count))]
        man.lastName  = lastNames[(Int)(arc4random() % (UInt32)(lastNames.count))]
        man.birthday = birthday
        
        return man
    }
    
    
    private class func isDuplicate(from duplicates: [String], with duplicate: String) -> Bool {
        
        for tempDuplicate in duplicates {
            
            if tempDuplicate == duplicate {
                return true
            }
        }
        return false
    }
    
// MARK: - Public function
    
    class func randomPeople(with number: Int) -> [Man] {
        
        var tempArray = [Man]()
        var duplicateNames = [String]()
        
        for _ in 0..<number {
            
            var man = randomMan()
            var fullname = man.firstName + man.lastName
            
            while isDuplicate(from: duplicateNames, with: fullname) {
                man = randomMan()
                fullname = man.firstName + man.lastName
            }
            tempArray.append(man)
            duplicateNames.append(fullname)
        }
        return tempArray
    }

}







