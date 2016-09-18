//
//  Swimmer.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

class Swimmer: Swimmers {
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    func swim() -> String {
        return "Swimmer \(self.name) is swimming"
    }
}
