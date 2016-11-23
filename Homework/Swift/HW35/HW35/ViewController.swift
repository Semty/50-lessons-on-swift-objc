//
//  ViewController.swift
//  HW35
//
//  Created by Руслан on 23.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Sorting: Int {
    
    case month
    case firstName
    case lastName
}

class ViewController: UITableViewController, UISearchBarDelegate {
    
// MARK: - Identifiers
    
    let identifier = "cell"

// MARK: - IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var sortingControl: UISegmentedControl!
    
// MARK: - Private variables
    
    private var isHide = false
    private var people = [Man]()
    private var sections = [Section]()
    private var currentOperation: Operation? = Operation()
    
// MARK: - Override functions of load the programm

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.people = Man.randomPeople(with: 2500)
        self.sortingAction(self.sortingControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Helpful functions
    
    func countPeople(from array: [Section]) -> Int {
        
        var count = 0
        
        for section in array {
            count += section.itemsArray.count
        }
        return count
    }
    
    func formatString(from date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM, yyyy"
        
        return formatter.string(from: date)
    }
    
    func month(from date: Date) -> (short: String, long: String) {
        
        let formatterShort = DateFormatter()
        formatterShort.dateFormat = "MMM"
        
        let formatterLong = DateFormatter()
        formatterLong.dateFormat = "MMMM"
        
        return (formatterShort.string(from: date),
                formatterLong.string(from: date))
    }
    
// MARK: - Generation
    
    func generateSectionsInBackground(from array: [Man], with filter: String) {
        
        self.currentOperation?.cancel()
        
        weak var weakSelf = self
        
        self.currentOperation = BlockOperation.init(block: { 
            
            let sections = weakSelf?.generateSections(from: array, with: filter)
            
            DispatchQueue.main.async {
                
                self.sections = sections!
                self.tableView.reloadData()
                
                self.currentOperation = nil
                
                if !self.isHide {
                    self.navigationItem.prompt = "In Search: \(weakSelf!.countPeople(from: sections!)) person(s)"
                }
            }
        })
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(self.currentOperation!)
    }
    
    func generateSections(from array: [Man], with filter: String) -> [Section] {
        
        var sections = [Section]()
        
        var currentMonth = ""
        var currentLetter = ""
        
        switch self.sortingControl.selectedSegmentIndex {
        case Sorting.month.rawValue:
            
            for man in array {
                
                let fullname = man.firstName + " " + man.lastName
                
                if filter.characters.count > 0 && (fullname.range(of: filter) == nil) {
                    continue
                }
                
                let month = self.month(from: man.birthday).long
                
                var section = Section()
                
                if currentMonth != month {
                    
                    section.sectionName = self.month(from: man.birthday).short
                    currentMonth = month
                    sections.append(section)
                } else {
                    section = sections.last!
                }
                section.itemsArray.append(man)
            }
            
            for section in sections {
                section.itemsArray = sorted(usingFullName: section.itemsArray, with: true)
            }
            
            return sections

        case Sorting.firstName.rawValue:
            
            for man in array {
                
                let fullname = man.firstName
                
                if filter.characters.count > 0 && (fullname.range(of: filter) == nil) {
                    continue
                }
                
                let firstLetter = (String)(man.firstName.characters.first!)
                
                var section = Section()
                
                if currentLetter != firstLetter {
                    
                    section.sectionName = firstLetter
                    currentLetter = firstLetter
                    sections.append(section)
                } else {
                    section = sections.last!
                }
                section.itemsArray.append(man)
            }
            return sections

        case Sorting.lastName.rawValue:
            
            for man in array {
                
                let fullname = man.lastName
                
                if filter.characters.count > 0 && (fullname.range(of: filter) == nil) {
                    continue
                }
                
                let firstLetter = (String)(man.lastName.characters.first!)
                
                var section = Section()
                
                if currentLetter != firstLetter {
                    
                    section.sectionName = firstLetter
                    currentLetter = firstLetter
                    sections.append(section)
                } else {
                    section = sections.last!
                }
                section.itemsArray.append(man)
            }
            return sections

        default:
            break
        }
     return sections
    }
    
// MARK: - Sorting
    
    func sorted(usingMonth array: [Man]) -> [Man] {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        
        let tempArray = array.sorted { man1, man2 in
            
            let date1 = formatter.string(from: man1.birthday)
            let date2 = formatter.string(from: man2.birthday)
            
            return date1 < date2
        }
        return tempArray
    }
    
    func sorted(usingFullName array: [Man], with priority: Bool) -> [Man] {
        
        if priority {
            
            let tempArray = array.sorted { man1, man2 in
                
                if man1.firstName == man2.firstName {
                    return man1.lastName < man2.lastName
                } else {
                    return man1.firstName < man2.firstName
                }
            }
            return tempArray
        } else {
            
            let tempArray = array.sorted { man1, man2 in
                
                if man1.lastName == man2.lastName {
                    return man1.firstName < man2.firstName
                } else {
                    return man1.lastName < man2.lastName
                }
            }
            return tempArray
        }
    }
    
// MARK: - UITableViewDataSource
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        
        var sectionNames = [String]()
        
        for section in self.sections {
            sectionNames.append(section.sectionName)
        }
        return sectionNames
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let man = self.sections[section].itemsArray[0]
        
        let month = self.month(from: man.birthday).long
        
        switch self.sortingControl.selectedSegmentIndex {
        case Sorting.month.rawValue:
            
            return "\(month) - \(self.sections[section].itemsArray.count) person(s)"
            
        default:
            
            return "\(self.sections[section].sectionName) - \(self.sections[section].itemsArray.count) person(s)"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! UserCell
        
        let man = self.sections[indexPath.section].itemsArray[indexPath.row]
        
        cell.fullname.text = "\(man.firstName) \(man.lastName)"
        cell.dateOfBirth.text = formatString(from: man.birthday)
        
        return cell
    }
    
// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK: - UISearchBarDelegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18, execute: {
            searchBar.resignFirstResponder()
        })
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(false, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18, execute: {
            searchBar.resignFirstResponder()
        })
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        generateSectionsInBackground(from: self.people, with: searchText)
    }

// MARK: - Actions
    
    @IBAction func sortingAction(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case Sorting.month.rawValue:
            
            self.people = sorted(usingMonth: self.people)
            
            generateSectionsInBackground(from: self.people, with: self.searchBar.text!)
            self.searchBar.placeholder = "Type FirstName or LastName"

        case Sorting.firstName.rawValue:
            
            self.people = sorted(usingFullName: self.people, with: true)
            
            generateSectionsInBackground(from: self.people, with: self.searchBar.text!)
            self.searchBar.placeholder = "Type FirstName"

        case Sorting.lastName.rawValue:
            
            self.people = sorted(usingFullName: self.people, with: false)
            
            generateSectionsInBackground(from: self.people, with: self.searchBar.text!)
            self.searchBar.placeholder = "Type LastName"

        default:
            break
        }
    }

    @IBAction func hideShowAction(_ sender: UIBarButtonItem) {
        
        if sender.title == "Hide" {
            
            self.isHide = true
            sender.title = "Show"
            self.navigationItem.prompt = nil
            
        } else {
            
            self.isHide = false
            sender.title = "Hide"
            self.navigationItem.prompt = "In Search: \(self.countPeople(from: sections)) person(s)"
        }
    }
}












