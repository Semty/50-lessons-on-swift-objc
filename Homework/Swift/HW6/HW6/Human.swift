//
//  Human.swift
//  HW6
//
//  Created by Руслан on 17.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Gender: String {
    case male, female
}

enum Direction: String {
    case ahead, back, left, right
}

class Human {

    let name: String
    let gender: Gender
    let direction: Direction
    
    init(name: String, gender: Gender, direction: Direction) {
        self.name = name
        self.gender = gender
        self.direction = direction
    }
}
