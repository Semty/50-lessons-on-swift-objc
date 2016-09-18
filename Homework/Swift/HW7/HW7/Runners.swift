//
//  Runners.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

protocol Runners {
    var name: String { get }
    
    func run() -> String
    
    func laugh() -> String
}