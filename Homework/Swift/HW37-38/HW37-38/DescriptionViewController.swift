//
//  DescriptionViewController.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class DescriptionViewController: UITableViewController {
    
// MARK: - IBOutlet's variables
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var adressLabel: UILabel!
    
// MARK: - Loading of the programm

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - Actions
    
    @IBAction func actionOKPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
