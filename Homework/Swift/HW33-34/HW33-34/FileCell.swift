//
//  FileCell.swift
//  HW33-34
//
//  Created by Руслан on 17.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class FileCell: UITableViewCell {
    
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var fileSizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
