//
//  Boxer.swift
//  HW5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Boxer: Human {
    
    let skinColor: String
    let nationality: String
    
    init(skinColor: String, nationality: String, name: String,
         height: Float, weight: Float, gender: String) {
        self.skinColor = skinColor
        self.nationality = nationality
        super.init(name: name, height: height, weight: weight, gender: gender)
    }

    override func movement() {
        super.movement()
        print("Boxer is moving")
    }
    
}
