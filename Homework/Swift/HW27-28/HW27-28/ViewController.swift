//
//  ViewController.swift
//  HW27-28
//
//  Created by Руслан on 01.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum TextFields: Int {
    
    case firstName = 0,
         lastName,
         login,
         password,
         age,
         phoneNumber,
         email
    
}

enum Codes: Int {
    
    case area
    case country
    
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown];
    }
    
// MARK: - Some static variables
    
    let localNumberMaxLength = 7
    let areaCodeMaxLength = 3
    let countryCodeMaxLength = 3
    
// MARK: - IBCollections
    
    @IBOutlet var smallLabelsCollection: [UILabel]!
    @IBOutlet var textFieldsCollection: [UITextField]!
    
// MARK: - ViewDidLoad and didReceiveMemoryWarning

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    func copyTextToSmallLabel(with textField: UITextField, _ range: NSRange, and string: String) {
        
        let smallLabel = smallLabelsCollection[textFieldsCollection.index(of: textField)!]
        
        smallLabel.text = textField.text! + string
        
        if string == "" {
            smallLabel.text = textField.text!.substring(to: textField.text!.index(before: textField.text!.endIndex))
        }
    }
    
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
        
        let smallLabel = smallLabelsCollection[textFieldsCollection.index(of: textField)!]
        smallLabel.text = resultString
        
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
        
        copyTextToSmallLabel(with: textField, range, and: string)
        
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
        
        copyTextToSmallLabel(with: textField, range, and: string)
        
        return true
    }
    
    func nameForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let validationSet = CharacterSet.letters.inverted
        let components = string.components(separatedBy: validationSet)
        
        if components.count > 1 {
            return false
        }
        
        copyTextToSmallLabel(with: textField, range, and: string)
        
        return true
    }
    
    func passwordForm(withTextField textField: UITextField, _ range: NSRange, and string: String) -> Bool {
        
        let smallLabel = smallLabelsCollection[textFieldsCollection.index(of: textField)!]
        
        if string == "" {
            let password = textField.text!.substring(to: textField.text!.index(before: textField.text!.endIndex))
            var newString = ""
            
            for _ in 0..<password.characters.count {
                newString += "*"
            }
            smallLabel.text! = newString
            return true
        }
        
        if textField.text!.characters.count > 23 && string != "" {
            return false
        }
        
        smallLabel.text! += "*"
        
        return true
    }
    
// MARK: - UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                                   replacementString string: String) -> Bool {
        
        let index: TextFields = TextFields(rawValue: textFieldsCollection.index(of: textField)!)!
        
        switch index {
        case .firstName:
            
            return nameForm(withTextField: textField, range, and: string)
        case .lastName:
            
            return nameForm(withTextField: textField, range, and: string)
        case .password:
            
            return passwordForm(withTextField: textField, range, and: string)
        case .age:
            
            return ageForm(withTextField: textField, range, and: string)
        case .phoneNumber:
            
            return phoneNumberForm(withTextField: textField, range, and: string)
        case .email:
            
            return emailForm(withTextField: textField, range, and: string)
        default:
            
            copyTextToSmallLabel(with: textField, range, and: string)
            return true
        }
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        
        let smallLabel = smallLabelsCollection[textFieldsCollection.index(of: textField)!]
        
        smallLabel.text = ""
        
        return true
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
}
