//
//  Animal.swift
//  HW5
//
//  Created by Руслан on 16.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class Animal {
    
    let species: String
    let name: String
    let age: Int
    
    init(species: String, name: String, age: Int) {
        self.species = species
        self.name = name
        self.age = age
    }
    
    func movement() {
        print("Animal is moving")
    }

}
