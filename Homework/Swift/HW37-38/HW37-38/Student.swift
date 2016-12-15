//
//  Student.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit
import MapKit

enum Gender {
    case man
    case woman
}

class Student: NSObject, MKAnnotation {
    
// MARK: - Public Variables
    
    var meetingState    = false
    var meetingDistance = "None"
    var gender:         Gender!
    
    let coordinate:     CLLocationCoordinate2D
    let title:          String?
    let subtitle:       String?
    
    var birthday        = "None"
    var name            = "None"
    var surname         = "None"
    
    let longitude: CLLocationDegrees!
    let latitude: CLLocationDegrees!
    
// MARK: - Static variables
    
    static let mainLatitude     = 55.755308
    static let mainLongitude    = 37.646547
    
    static let firstNames = ["Tran", "Lenore", "Bud", "Fredda", "Katrice",
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
    
    static let lastNames = ["Farrah", "Laviolette", "Heal", "Sechrest", "Roots",
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
    
// MARK: - Initialization
    
    override init() {
        
        self.name = Student.firstNames  [ (Int)(arc4random() % (UInt32)(Student.firstNames.count)) ]
        self.surname = Student.lastNames[ (Int)(arc4random() % (UInt32)(Student.lastNames.count))  ]
        
        var plusOrMinus: Double = arc4random() % 2 == 0 ? -1 : 1
        self.longitude = ((Double)(arc4random() % 5000) / 100000 * plusOrMinus) + Student.mainLongitude
        plusOrMinus = arc4random() % 2 == 0 ? -1 : 1
        self.latitude = ((Double)(arc4random() % 5000) / 100000 * plusOrMinus) + Student.mainLatitude
        
        let tempCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.coordinate = tempCoordinate
        
        self.title = "\(self.name) \(self.surname)"
        
        // 17 age = 536 112 000
        // 8  age = 252 288 000
        
        let intervalBetween17and25Ages: TimeInterval = (TimeInterval)(arc4random() % 252288000 + 536112000)
        
        let dateOfBirthday = Date(timeIntervalSinceNow: -intervalBetween17and25Ages)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM, yyyy"
        
        self.birthday = dateFormatter.string(from: dateOfBirthday)
        self.subtitle = self.birthday
        
        self.gender = arc4random() % 2 == 0 ? .woman : .man
    }
}
