//
//  MeetingViewCell.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class MeetingViewCell: UITableViewCell {
    
// MARK: - IBOutlet's variables
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var meetingStatus: UIImageView!
    @IBOutlet weak var meetingDistanceLabel: UILabel!
    
// MARK: - awakeFromNib() and setSelected(::)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
