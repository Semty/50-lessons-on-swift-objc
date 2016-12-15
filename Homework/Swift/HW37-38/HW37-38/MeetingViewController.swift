//
//  MeetingViewController.swift
//  HW37-38
//
//  Created by Руслан on 15.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

protocol AmountOfStudents {
    
    var students:               [Student] { get }
    
    var withoutCircleStudents:  [Student] { get }
    var firstCircleStudents:    [Student] { get }
    var secondCircleStudents:   [Student] { get }
    var thirdCircleStudents:    [Student] { get }
}

class MeetingViewController: UITableViewController {
    
// MARK: - Variables
    
    var delegate: AmountOfStudents!
    let identifier = "identifier"
    
// MARK: - Loading of the programm

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "0 - 2 km, \(delegate.firstCircleStudents.count) person(s)"
        } else if section == 1 {
            return "2 - 5 km, \(delegate.secondCircleStudents.count) person(s)"
        } else if section == 2 {
            return "5 - 8.5 km, \(delegate.thirdCircleStudents.count) person(s)"
        } else {
            return "8.5 - ... km, \(delegate.withoutCircleStudents.count) persons(s)"
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return delegate.firstCircleStudents.count
        } else if section == 1 {
            return delegate.secondCircleStudents.count
        } else if section == 2 {
            return delegate.thirdCircleStudents.count
        } else {
            return delegate.withoutCircleStudents.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifier) as! MeetingViewCell
        
        var student: Student!
        
        if indexPath.section == 0 {
            student = self.delegate.firstCircleStudents[indexPath.row]
        } else if indexPath.section == 1 {
            student = self.delegate.secondCircleStudents[indexPath.row]
        } else if indexPath.section == 2 {
            student = self.delegate.thirdCircleStudents[indexPath.row]
        } else {
            student = self.delegate.withoutCircleStudents[indexPath.row]
        }
        
        cell.fullNameLabel.text         = "\(student.name) \(student.surname)"
        cell.meetingDistanceLabel.text  = "\(student.meetingDistance) km"
        
        if student.meetingState {
            cell.meetingStatus.image = UIImage.init(named: "checked")
        } else {
            cell.meetingStatus.image = UIImage.init(named: "cancel")
        }

        return cell
    }
    
// MARK: - Actions
    
    @IBAction func actionOKPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
