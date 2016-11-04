//
//  RegFormViewController.swift
//  HW29
//
//  Created by Руслан on 04.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum TextFields: Int {
    
    case login = 0,
    password,
    firstName,
    lastName,
    age,
    phoneNumber,
    email
    
}

enum Codes: Int {
    
    case area
    case country
    
}

class RegFormViewController: UITableViewController, UITextFieldDelegate {
    
// MARK: - Some static variables
    
    let localNumberMaxLength = 7
    let areaCodeMaxLength = 3
    let countryCodeMaxLength = 3
    
// MARK: - IBOutlets
    
    @IBOutlet var textFieldsCollection: [UITextField]!
    @IBOutlet weak var genderControl: UISegmentedControl!
    @IBOutlet weak var subscriptionSwitch: UISwitch!
    
// MARK: - Keys for userDefaults
    
    let kLogin              = "login"
    let kPassword           = "password"
    let kFirstName          = "firstName"
    let kLastName           = "lastName"
    let kAge                = "age"
    let kPhoneNumber        = "phoneNumber"
    let kEmail              = "email"
    let kGender             = "gender"
    let kNewsSubscription   = "newsSubscription"
    
// MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        let insets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        self.tableView.contentInset = insets
        
        loadInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all;
    }
    
    // MARK: - Helpful functions
    
    func makeSubRange(of string: String, withStartPoint startPoint: Int, andEndPoint endPoint: Int, forCode code: Codes) -> String {
        
        if let range = string.range(of: string) {
            
            let startRange = string.index(range.lowerBound,
                                          offsetBy: startPoint)
            let lastRange = string.index(range.lowerBound,
                                         offsetBy: startPoint + endPoint)
            
            let subRange = startRange..<lastRange
            
            var form = string.substring(with: subRange)
            
            if code == .area {
                form = "(\(form)) "
            } else {
                form = "+\(form) "
            }
            
            return form
        }
        return ""
    }
    
    // MARK: - TextFields private methods
    
    func phoneNumberForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let validationSet = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        var newString = textField.text! + string
        
        let newComponents = newString.components(separatedBy: validationSet)
        newString = newComponents.joined(separator: "")
        
        if string == "" {
            
            newString = newString.substring(to: newString.index(before: newString.endIndex))
        }
        
        var resultString = ""
        
        if newString.characters.count > localNumberMaxLength + areaCodeMaxLength + countryCodeMaxLength  {
            return false
        }
        
        let localNumberLength = min(newString.characters.count, localNumberMaxLength)
        
        if localNumberLength >= 0 {
            
            let number = newString.substring(from:
                newString.index(newString.startIndex,
                                offsetBy: newString.characters.count - localNumberLength))
            
            resultString += number
            
            if resultString.characters.count > 3 {
                resultString.insert("-", at: resultString.index(resultString.startIndex, offsetBy: 3))
            }
            
            if resultString.characters.count > 6 {
                resultString.insert("-", at: resultString.index(resultString.startIndex, offsetBy: 6))
            }
        }
        
        if newString.characters.count > localNumberMaxLength {
            
            let areaCodeLength = min(newString.characters.count - localNumberMaxLength, areaCodeMaxLength)
            
            let area = makeSubRange(of: newString,
                                    withStartPoint: newString.characters.count - localNumberMaxLength - areaCodeLength,
                                    andEndPoint: areaCodeLength,
                                    forCode: .area)
            
            resultString = area + resultString
        }
        
        if newString.characters.count > localNumberMaxLength + areaCodeMaxLength {
            
            let countryCodeLength = min(newString.characters.count - localNumberMaxLength - areaCodeMaxLength,
                                        countryCodeMaxLength)
            
            let country = makeSubRange(of: newString,
                                       withStartPoint: newString.characters.count - localNumberMaxLength -
                                        areaCodeMaxLength - countryCodeLength,
                                       andEndPoint: countryCodeLength,
                                       forCode: .country)
            
            resultString = country + resultString
        }
        
        textField.text = resultString
        
        return false
    }
    
    func ageForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let validationSet = CharacterSet.decimalDigits.inverted
        let components = string.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        let newString = textField.text! + string
        
        if (Int)(newString) ?? 0 > 150 || (textField.text! == "0" && string != "") {
            return false
        }
        
        return true
    }
    
    func emailForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        var validationSet = CharacterSet.alphanumerics
        validationSet.formUnion(CharacterSet.init(charactersIn: "@_.-"))
        
        var components = string.components(separatedBy: validationSet.inverted)
        
        if components.count > 1 {
            return false
        }
        
        if string == "@" {
            
            components = textField.text!.components(separatedBy: "@")
            if components.count > 1 {
                return false
            }
        }
        
        if textField.text!.characters.count > 23 && string != "" {
            return false
        }
        
        return true
    }
    
    func nameForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let validationSet = CharacterSet.letters.inverted
        let components = string.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        let index: TextFields = TextFields(rawValue: textFieldsCollection.index(of: textField)!)!
        
        saveInfo()
        
        switch index {
        case .firstName:
            
            return nameForm(withTextField: textField, range, and: string)
        case .lastName:
            
            return nameForm(withTextField: textField, range, and: string)
        case .age:
            
            return ageForm(withTextField: textField, range, and: string)
        case .phoneNumber:
            
            return phoneNumberForm(withTextField: textField, range, and: string)
        case .email:
            
            return emailForm(withTextField: textField, range, and: string)
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let currentIndex = textFieldsCollection.index(of: textField)!
        
        if textField != textFieldsCollection.last {
            textFieldsCollection[currentIndex + 1].becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        
        return true
    }
    
// MARK: - Save and Load
    
    func saveInfo() {
        
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(textFieldsCollection[TextFields.login.rawValue].text,       forKey: kLogin)
        userDefaults.set(textFieldsCollection[TextFields.password.rawValue].text,    forKey: kPassword)
        userDefaults.set(textFieldsCollection[TextFields.firstName.rawValue].text,   forKey: kFirstName)
        userDefaults.set(textFieldsCollection[TextFields.lastName.rawValue].text,    forKey: kLastName)
        userDefaults.set(textFieldsCollection[TextFields.age.rawValue].text,         forKey: kAge)
        userDefaults.set(textFieldsCollection[TextFields.phoneNumber.rawValue].text, forKey: kPhoneNumber)
        userDefaults.set(textFieldsCollection[TextFields.email.rawValue].text,       forKey: kEmail)
        
        userDefaults.set(genderControl.selectedSegmentIndex,            forKey: kGender)
        userDefaults.set(subscriptionSwitch.isOn,                       forKey: kNewsSubscription)
        
        userDefaults.synchronize()
    }
    
    func loadInfo() {
        
        let userDefaults = UserDefaults.standard
        
        textFieldsCollection[TextFields.login.rawValue].text = userDefaults.string(forKey:          kLogin)
        textFieldsCollection[TextFields.password.rawValue].text = userDefaults.string(forKey:       kPassword)
        textFieldsCollection[TextFields.firstName.rawValue].text = userDefaults.string(forKey:      kFirstName)
        textFieldsCollection[TextFields.lastName.rawValue].text = userDefaults.string(forKey:       kLastName)
        textFieldsCollection[TextFields.age.rawValue].text = userDefaults.string(forKey:            kAge)
        textFieldsCollection[TextFields.phoneNumber.rawValue].text = userDefaults.string(forKey:    kPhoneNumber)
        textFieldsCollection[TextFields.email.rawValue].text = userDefaults.string(forKey:          kEmail)
        
        genderControl.selectedSegmentIndex = userDefaults.integer(forKey:   kGender)
        subscriptionSwitch.isOn = userDefaults.bool(forKey:                 kNewsSubscription)
    }
    
// MARK: - Actions
    
    @IBAction func valueChanged(_ sender: Any) {
        saveInfo()
    }
}
