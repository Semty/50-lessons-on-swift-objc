//
//  ViewController.swift
//  HW36
//
//  Created by Руслан on 03.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController:   UITableViewController, ViewControllerDelegate,
                        EducationControllerDelegate, UIPopoverPresentationControllerDelegate, UITextFieldDelegate {
    
// MARK: - Keys for NSUserDefaults
    
    let kFirstName      = "firstname"
    let kLastName       = "lastname"
    let kGender         = "gender"
    let kDateOfBirth    = "dateofbirth"
    let kEducation      = "education"

// MARK: - IBOutlet's
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var educationField: UITextField!
    
// MARK: - Override programm functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Actions
    
    @IBAction func actionSaveInfo(_ sender: UIButton) {
        
       self.saveInfo()
        
        let indexPath = IndexPath(row: 0, section: 1)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func actionDeleteInfo(_ sender: UIButton) {
        
        self.firstNameField.text = "";
        self.lastNameField.text = "";
        self.genderControl.selectedSegmentIndex = 0;
        self.dateOfBirthField.text = "";
        self.educationField.text = "";
        
        let indexPath = IndexPath(row: 0, section: 2)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK: - Save and Load Info
    
    func saveInfo() {
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(self.firstNameField.text, forKey: kFirstName)
        userDefaults.set(self.lastNameField.text, forKey: kLastName)
        userDefaults.set(self.dateOfBirthField.text, forKey: kDateOfBirth)
        userDefaults.set(self.educationField.text, forKey: kEducation)
        userDefaults.set(self.genderControl.selectedSegmentIndex, forKey: kGender)
        
        userDefaults.synchronize()
    }
    
    func loadInfo() {
        
        let userDefaults = UserDefaults.standard
        
        self.firstNameField.text = userDefaults.string(forKey: kFirstName)
        self.lastNameField.text = userDefaults.string(forKey: kLastName)
        self.dateOfBirthField.text = userDefaults.string(forKey: kDateOfBirth)
        self.educationField.text = userDefaults.string(forKey: kEducation)
        self.genderControl.selectedSegmentIndex = userDefaults.integer(forKey: kGender)
        
        userDefaults.synchronize()
    }
    
// MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.firstNameField.resignFirstResponder()
        self.lastNameField.resignFirstResponder()
        
        if segue.identifier == "showDateOfBirth" || segue.identifier == "showInfo" {
            
            let vc = segue.destination as! DateViewController
            vc.delegate = self
            vc.popoverPresentationController?.delegate = self
            
        } else if segue.identifier == "showEducation" {
            
            let vc = segue.destination as! EducationViewController
            vc.delegate = self
            vc.popoverPresentationController?.delegate = self
        }
    }
    
// MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstNameField {
            self.lastNameField.becomeFirstResponder()
        } else {
            self.lastNameField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.dateOfBirthField {
            
            self.performSegue(withIdentifier: "showDateOfBirth", sender: textField)
            return false
            
        } else if textField == self.educationField {
            
            self.performSegue(withIdentifier: "showEducation", sender: textField)
            return false
        }
        
        return true
    }
    
// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController,
                                            traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }

}
