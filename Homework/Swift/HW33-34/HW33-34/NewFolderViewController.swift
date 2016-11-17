//
//  NewFolderViewController.swift
//  HW33-34
//
//  Created by Руслан on 17.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class NewFolderViewController: UIViewController, UITextFieldDelegate {
    
    var folderName = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Actions
    
    @IBAction func actionTextField(_ sender: UITextField) {
        self.folderName = sender.text!
    }
    
    @IBAction func actionCreateFolder(_ sender: UIButton) {
        
        let index = (self.navigationController?.viewControllers.index(of: self))!
        
        let vc = self.navigationController?.viewControllers[index - 1] as! DirectoryViewController
        let filePath = vc.path.stringByAppendingPathComponent(path: self.folderName)
        
        do {
            try FileManager.default.createDirectory(atPath: filePath,
                                                    withIntermediateDirectories: false, attributes: nil)
            vc.contents.insert(folderName, at: 0)
            vc.tableView.reloadData()
            _ = self.navigationController?.popViewController(animated: true)
        } catch let error as NSError {
            print("\n\n\n\(error.localizedDescription)\n\n")
            
            var errorMessage = ""
            
            if self.folderName.characters.count == 0 {
                errorMessage = "Text field is empty. Please, enter a name of the folder"
            } else {
                errorMessage = "File with this name already exist. Please, enter another name"
            }
            
            let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
            
            alert.addAction(actionOk)
            self.present(alert, animated: true, completion: nil)
        }
    }

// MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
