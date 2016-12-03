//
//  EducationViewController.swift
//  HW36
//
//  Created by Руслан on 03.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

protocol EducationControllerDelegate {
    
    var educationField: UITextField! { get set }
}

class EducationViewController: UITableViewController {
    
// MARK: - Variables
    
    var delegate: EducationControllerDelegate!
    
// MARK: - Override programm functions

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let education = tableView.cellForRow(at: indexPath)?.textLabel?.text
        self.delegate.educationField.text = education
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(education, forKey: "education")
        userDefaults.synchronize()
        
        self.dismiss(animated: true, completion: nil)
    }

}
