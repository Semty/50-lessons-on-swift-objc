//
//  DateViewController.swift
//  HW36
//
//  Created by Руслан on 03.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate {
    
    weak var dateOfBirthField: UITextField! { get set }
}

class DateViewController: UIViewController {
    
// MARK: - Variables
    
    var delegate: ViewControllerDelegate!
    private var formatter: DateFormatter!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
// MARK: - Override programm functions

    override func viewDidLoad() {
        super.viewDidLoad()

        let formatter = DateFormatter.init()
        formatter.dateFormat = "dd MMMM, yyyy"
        self.formatter = formatter
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Actions
    
    @IBAction func actionDateChanged(_ sender: UIDatePicker) {
        
        let stringDate = self.formatter.string(from: sender.date)
        self.delegate.dateOfBirthField.text = stringDate
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(stringDate, forKey: "dateofbirth")
        userDefaults.synchronize()
    }
    
    @IBAction func actionDonePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
