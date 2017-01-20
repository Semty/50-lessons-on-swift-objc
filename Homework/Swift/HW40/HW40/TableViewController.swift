//
//  TableViewController.swift
//  HW40
//
//  Created by Руслан on 20.01.17.
//  Copyright © 2017 Ruslan Timchenko. All rights reserved.
//

import UIKit

class TableViewController:  UITableViewController,
                            DateViewControllerDelegate,
                            UIPopoverPresentationControllerDelegate,
                            UITextFieldDelegate {
    
// MARK: - Protocol (DateViewControllerDelegate) Conforming Variables
    
    var student: Student!
    @IBOutlet weak var dateOfBirthField: UITextField!
    
// MARK: - Public Variables
    
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var gradeSlider: UISlider!
    
// MARK: - Private Keys
    
    private let kFirstName      = "firstName";
    private let kLastName       = "lastName";
    private let kDateOfBirth    = "dateOfBirth";
    private let kGender         = "gender";
    private let kGrade          = "grade";
    
// MARK: - Programm Execution
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.student = Student()
        
        self.student.addObserver(self,
                                 forKeyPath: kFirstName,
                                 options: [.new, .old],
                                 context: nil)
        
        self.student.addObserver(self,
                                 forKeyPath: kLastName,
                                 options: [.new, .old],
                                 context: nil)
        
        self.student.addObserver(self,
                                 forKeyPath: kDateOfBirth,
                                 options: [.new, .old],
                                 context: nil)
        
        self.student.addObserver(self,
                                 forKeyPath: kGender,
                                 options: [.new, .old],
                                 context: nil)
        
        self.student.addObserver(self,
                                 forKeyPath: kGrade,
                                 options: [.new, .old],
                                 context: nil)
        
        /*
         
         //                                     *** MASTER && SUPERMAN ***
         
        let student1 = Student()
        let student2 = Student()
        let student3 = Student()
        let student4 = Student()
        
        student4.friend = student3
        student3.friend = student2
        student2.friend = student1
        student1.friend = self.student
        self.student.friend = student4
        
        let students = [student4, student3, student2, student1, self.student]
        
        for student in students {
            student?.setValue("kek", forKey: "lastName")
        }
        
        let allNames = (students as AnyObject).value(forKeyPath: "@distinctUnionOfObjects.firstName") as! [String]
        let minBirth = (students as AnyObject).value(forKeyPath: "@min.dateOfBirth") as! Date
        let maxBirth = (students as AnyObject).value(forKeyPath: "@max.dateOfBirth") as! Date
        let avgGrade = (students as AnyObject).value(forKeyPath: "@avg.grade") as! Double
        let sumAllGrade = (students as AnyObject).value(forKeyPath: "@sum.grade") as! Double
        
        print("\n \n ALL NAMES: \(allNames) \n")
        print("\n \n MIN BIRTH: \(minBirth) \n")
        print("\n \n MAX BIRTH: \(maxBirth) \n")
        print("\n \n AVG GRADE: \(avgGrade) \n")
        print("\n \n SUM ALL GRADE: \(sumAllGrade) \n")
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Observing
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        print("\n\nobserveValueForKeyPath: \(keyPath)\nobject: \(object)\nchange: \(change)\n")
    }
    
// MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        self.firstNameField.resignFirstResponder()
        self.lastNameField.resignFirstResponder()
        
        if segue.identifier == "showDateOfBirth" {
            
            let vc = segue.destination as! DateViewController
            vc.delegate = self
            vc.popoverPresentationController?.delegate = self
            
            let popover = vc.popoverPresentationController
            
            let textField = sender as! UITextField
            
            let popoverRect = textField.convert(textField.frame, to: self.view)
            
            popover?.sourceView = self.view
            popover?.sourceRect = popoverRect
        }
        
    }
    
// MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.firstNameField {
            self.lastNameField.becomeFirstResponder()
        } else if textField == self.lastNameField {
            self.lastNameField.resignFirstResponder()
        }
        
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.dateOfBirthField {
            self.performSegue(withIdentifier: "showDateOfBirth", sender: textField)
            return false
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == self.firstNameField {
            self.student.firstName = textField.text!
        } else if textField == self.lastNameField {
            self.student.lastName = textField.text!
        }
        
        return true
    }

// MARK: - Actions
    
    @IBAction func actionGenderChanged(_ sender: UISegmentedControl) {
        
        switch (sender.selectedSegmentIndex) {
        case Gender.man.rawValue:
            self.student.gender = 0
        case Gender.woman.rawValue:
            self.student.gender = 1
        default:
            break
        }
        
    }
    
    @IBAction func actionGradeChanged(_ sender: UISlider) {
        self.gradeLabel.text = String.init(format: "%1.1f", sender.value)
        self.student.grade = Double(sender.value)
    }
    
    @IBAction func actionReset(_ sender: UIButton) {
        
        self.firstNameField.text = ""
        self.lastNameField.text = ""
        self.genderSegmentedControl.selectedSegmentIndex = 0
        self.dateOfBirthField.text = ""
        self.gradeLabel.text = "2.5"
        self.gradeSlider.value = 2.5
        
        self.student.resetAllProperties()
    }
    
// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK: - UIPopoverPresentationControllerDelegate
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

}
