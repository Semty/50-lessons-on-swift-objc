//
//  Swimmers.swift
//  HW7
//
//  Created by Руслан on 19.09.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import Foundation

protocol Swimmers {
    var name: String { get }
    
    func swim() -> String
}