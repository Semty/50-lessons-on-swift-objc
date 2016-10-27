//
//  ViewController.swift
//  HW25
//
//  Created by Руслан on 27.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

// MARK: - Enum Actions

enum Actions: Int {
    
    case plus = 10,
    minus, multiplication,
    division, modulo, plusMinus,
    equal, erase, delete, numPoint,
    none, active
    
}

// MARK: - ViewController

class ViewController: UIViewController {
    
// MARK: - Properties
    
    @IBOutlet weak var outputLabel: UILabel!
    
    var stringNumbers = ""
    var arrayNumbers = [Double]()
    var operand: Double!
    var actionBetweenNumbers = Actions.none
    var storageAction = Actions.none
    var startWithDifferentNumbers = Actions.active
    
// MARK: - Supported Orientations

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }
    
// MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let kek: Double = 1;
        print(kek)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Helpful Functions
    
    func removeAllZeroes(_ num: Double) -> String {
        print("RemoveAllZeroes")
        
        var string = (String)(num)
        
        for (index, char) in string.characters.enumerated().reversed() {
            
            if char == "0" && string.characters.count != 1 {
                string.remove(at: string.index(string.startIndex, offsetBy: index))
            } else if char == "." {
                string.remove(at: string.index(string.startIndex, offsetBy: index))
                break
            } else {
                break
            }
        }
        
        return string
    }
    
    func plusMinusAction() {
        print("PlusMinus")
        
        let number = ((Double)(stringNumbers) ?? 0) * (-1)
        stringNumbers = removeAllZeroes(number)
        outputLabel.text = stringNumbers
    }
    
    func eraseAction() {
        print("Erase")
        
        if stringNumbers.characters.count > 1 {
            stringNumbers.remove(at: stringNumbers.index(before: stringNumbers.endIndex))
            outputLabel.text = stringNumbers
        } else if stringNumbers.characters.count == 1 {
            
            stringNumbers = ""
            outputLabel.text = "0"
        }
    }
    
    func deleteAction() {
        print("Delete")
        
        actionBetweenNumbers = .none
        storageAction = .none
        stringNumbers = ""
        outputLabel.text = "0"
        arrayNumbers.removeAll()
    }
    
    func addPointAction() {
        print("addPoint")
        
        var tempNumber = removeAllZeroes((Double)(stringNumbers) ?? 0)
        
        if !tempNumber.contains(".") {
            tempNumber += "."
        }
        
        stringNumbers = tempNumber
        outputLabel.text = stringNumbers
    }
    
    func plusAllOperands() {
        
        let number = (Double)(stringNumbers) ?? 0
        arrayNumbers.append(number)
        print("Numbers: \(arrayNumbers)")
        outputLabel.text = stringNumbers
        stringNumbers = ""
    }
    
    func printNumberInOutput() {
        
        if !(operand == 0 && (outputLabel.text == "0" || outputLabel.text == "-0")) {
            
            if outputLabel.text == "0" || outputLabel.text == "-0" {
                stringNumbers = String.init(format: "%1.f", operand)
                outputLabel.text = stringNumbers
            } else {
                stringNumbers += String.init(format: "%1.f", operand)
                outputLabel.text = stringNumbers
            }
        }
    }
    
    func countNumbersAndReturnString(_ string: String) -> String {
        
        if string.characters.count <= 12 {
            return string
        } else {
            var tempString = string
            let lastSymbol = (tempString.remove(at: string.index(after: string.index(string.startIndex, offsetBy: 11))))
            let lS = (Int)((String)(lastSymbol))
            let lsString = lS! > 4 ? "\(lS! + 1)" : "\(lS!)"
            return string.substring(to: string.index(string.startIndex, offsetBy: 11)) + lsString
        }
    }
    
    func calculateResultInOutput() {
        print("Equal")
        
        let operand1 = arrayNumbers.first ?? 0
        let operand2 = arrayNumbers.last ?? 0
        print("op1: \(operand1), op2: \(operand2)")
        
        var resultString = ""
        
        switch actionBetweenNumbers {
        case .plus:
            
            print("Plus")
            operand = operand1 + operand2
            resultString = removeAllZeroes(operand)
            outputLabel.text = countNumbersAndReturnString(resultString)
            
        case .multiplication:
            
            print("Multiplication")
            operand = operand1 * operand2
            resultString = removeAllZeroes(operand)
            outputLabel.text = countNumbersAndReturnString(resultString)
            
        case .division:
            
            print("Division")
            operand = operand1 / operand2
            resultString = removeAllZeroes(operand)
            outputLabel.text = countNumbersAndReturnString(resultString)
            
        case .minus:
            
            print("Minus")
            operand = operand1 - operand2
            resultString = removeAllZeroes(operand)
            outputLabel.text = countNumbersAndReturnString(resultString)
            
        case .modulo:
            
            print("Modulo")
            operand = (Double)((Int)(operand1) % (Int)(operand2))
            resultString = removeAllZeroes(operand)
            outputLabel.text = countNumbersAndReturnString(resultString)
            
        default: break
        }
        
        arrayNumbers.removeAll()
        stringNumbers = removeAllZeroes(operand)
        actionBetweenNumbers = .none
        storageAction = .none
        startWithDifferentNumbers = .none
    }
    
    func whatIsBeingPushed(_ tag: Int) {
        
        switch tag {
        case 0...9: // buttons - (0...9)
            
            if actionBetweenNumbers == .none && startWithDifferentNumbers != .none {
                operand = (Double)(tag)
                printNumberInOutput()
            } else if startWithDifferentNumbers == .active {
                
                plusAllOperands()
                operand = (Double)(tag)
                printNumberInOutput()
                storageAction = actionBetweenNumbers
                actionBetweenNumbers = .none
            } else {
                
                stringNumbers = ""
                operand = (Double)(tag)
                printNumberInOutput()
                startWithDifferentNumbers = .active
            }
            
        case 15:                                            // button - PlusMinus
            plusMinusAction()
        case 17:                                            // button - Erase
            eraseAction()
        case 18:                                            // button - Delete
            deleteAction()
        case 19:                                            // button - Point
            addPointAction()
        case 10...14:                                       // buttons - (Plus, Minus, Multiplication, Division, Modulo)
            actionBetweenNumbers = Actions(rawValue: tag)!
            startWithDifferentNumbers = .active
        default:                                            // button - Equal
            actionBetweenNumbers = storageAction
            if actionBetweenNumbers != .none {
                plusAllOperands()
                calculateResultInOutput()
            }
        }
        
    }
    
// MARK: - Calculator Actions
    
    @IBAction func calculatorAction(_ sender: UIButton) {
        whatIsBeingPushed(sender.tag)
    }

}

