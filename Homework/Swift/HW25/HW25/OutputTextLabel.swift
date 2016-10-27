//
//  OutputTextLabel.swift
//  HW25
//
//  Created by Руслан on 27.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class OutputTextLabel: UILabel {

    override func drawText(in rect: CGRect) {
        
        let insetNumbersInOutput = UIEdgeInsetsMake(rect.height / 2, 0,
                                                    0, rect.width / 10)
        
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insetNumbersInOutput))
    }

}
