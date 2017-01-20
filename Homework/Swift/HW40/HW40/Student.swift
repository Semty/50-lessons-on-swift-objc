//
//  Student.swift
//  HW40
//
//  Created by Руслан on 20.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Gender: Int {
    
    case man
    case woman
    
}

class Student: NSObject {
    
// MARK: - Public Variables
    
    weak var friend: Student?
    
    dynamic var firstName: String?
    dynamic var lastName: String?
    dynamic var dateOfBirth: Date?
    dynamic var gender: Gender.RawValue = Gender.man.rawValue
    dynamic var grade: Double
    
// MARK: - Private Static Variables
    
    private static let firstNames = [
    "Tran", "Lenore", "Bud", "Fredda", "Katrice",
    "Clyde", "Hildegard", "Vernell", "Nellie", "Rupert",
    "Billie", "Tamica", "Crystle", "Kandi", "Caridad",
    "Vanetta", "Taylor", "Pinkie", "Ben", "Rosanna",
    "Eufemia", "Britteny", "Ramon", "Jacque", "Telma",
    "Colton", "Monte", "Pam", "Tracy", "Tresa",
    "Willard", "Mireille", "Roma", "Elise", "Trang",
    "Ty", "Pierre", "Floyd", "Savanna", "Arvilla",
    "Whitney", "Denver", "Norbert", "Meghan", "Tandra",
    "Jenise", "Brent", "Elenor", "Sha", "Jessie", "Akram",
    "Ruslan", "Dasha", "Sergey", "Sveta", "Zahar"
    ]
    
    private static let lastNames = [
    "Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
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
    "Glushko"
    ]
    
    private static let namesCount = 56;
    
// MARK: - Inialization
    
    override init () {
        
        self.firstName = Student.firstNames[(Int)(arc4random_uniform(UInt32(Student.namesCount)))]
        self.lastName = Student.lastNames[(Int)(arc4random_uniform(UInt32(Student.namesCount)))]
        self.grade = (Double)(arc4random_uniform(201)) / 100.0 + 2.0
        self.dateOfBirth = Date.init(timeIntervalSince1970: (TimeInterval)(arc4random_uniform(1450656000)))
        self.gender = Int(arc4random_uniform(2))
        
        super.init()
    }
    
// MARK: - Reset Function
    
    func resetAllProperties() {
        
        firstName = nil
        lastName = nil
        dateOfBirth = nil
        gender = 0
        grade = 2.5
        
    }
    
// MARK: - Override Undefined Keys
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\n\n!!! setValueForUndefinedKey = \(key) \n")
    }

    override func value(forUndefinedKey key: String) -> Any? {
        
        print("\n\n!!! valueForUndefinedKey = \(key) \n")
        
        return nil
    }
}








