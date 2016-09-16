//
//  Human.swift
//  HW5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Human {
    let name: String
    let height: Float
    let weight: Float
    let gender: String
    
    init(name: String, height: Float, weight: Float, gender: String) {
        self.name = name
        self.height = height
        self.weight = weight
        self.gender = gender
    }
    
    func movement() {
        print("Human is moving")
    }
    
}
