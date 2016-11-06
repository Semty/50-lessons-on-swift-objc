//
//  ViewController.swift
//  HW30
//
//  Created by Руслан on 06.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
// MARK: - Private properties
    
    private var randomColors = [RandomColor]()
    private var allStudents  = [Student]()
    
    private var studentsLowMarks        = [Student]()
    private var studentsMediocreMarks   = [Student]()
    private var studentsGoodMarks       = [Student]()
    private var studentsExcellentMarks  = [Student]()
    
// MARK: - TableView and viewDidLoad

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // colors
        for _ in 0..<5 {
            let color = RandomColor()
            randomColors.append(color)
        }
        // students
        for _ in 0..<25 {
            
            let student = Student()
            allStudents.append(student)
            
            if student.averageMark < 2.5 {
                studentsLowMarks.append(student)
            } else if student.averageMark < 3.5 {
                studentsMediocreMarks.append(student)
            } else if student.averageMark < 4.5 {
                studentsGoodMarks.append(student)
            } else {
                studentsExcellentMarks.append(student)
            }
        }
        
        sortedByNames(&studentsLowMarks)
        sortedByNames(&studentsMediocreMarks)
        sortedByNames(&studentsGoodMarks)
        sortedByNames(&studentsExcellentMarks)
        
        allStudents = allStudents.sorted() { student1, student2 in
            return student1.averageMark > student2.averageMark
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Helpful functions
    
    func sortedByNames(_ students: inout [Student]) {
        
        students = students.sorted() { student1, student2 in
            
            if student1.lastName == student2.lastName {
                return student1.firstName > student2.firstName
            } else {
                return student1.lastName > student2.lastName
            }
        }
    }
    
// MARK: - UITableViewDataSource
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return studentsLowMarks.count
        case 1:
            return studentsMediocreMarks.count
        case 2:
            return studentsGoodMarks.count
        case 3:
            return studentsExcellentMarks.count
        case 4:
            return randomColors.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "Low mark students"
        case 1:
            return "Mediocre students"
        case 2:
            return "Good mark students"
        case 3:
            return "Excellent mark students"
        case 4:
            return "Colors"
        default:
            return "Default"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let color = "color"
        let student = "student"
        
        var cell: UITableViewCell?
        
        if indexPath.section == 4 {
            
            cell = tableView.dequeueReusableCell(withIdentifier: color)
            
            if cell == nil {
                cell = UITableViewCell.init(style: .default, reuseIdentifier: color)
            }
            
            cell?.backgroundColor = randomColors[indexPath.row].color
            cell?.textLabel?.textColor = UIColor.white
            cell?.textLabel?.shadowColor = UIColor.black
            cell?.textLabel?.textAlignment = .center
            cell?.textLabel?.text = randomColors[indexPath.row].name
            
            return cell!
            
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: student)
            
            if cell == nil {
                cell = UITableViewCell.init(style: .value1, reuseIdentifier: student)
            }
            
            let student: Student
            
            switch indexPath.section {
            case 0:
                student = studentsLowMarks[indexPath.row]
                cell?.textLabel?.textColor = UIColor.red
            case 1:
                student = studentsMediocreMarks[indexPath.row]
                cell?.textLabel?.textColor = UIColor.orange
            case 2:
                student = studentsGoodMarks[indexPath.row]
                cell?.textLabel?.textColor = UIColor.magenta
            default:
                student = studentsExcellentMarks[indexPath.row]
                cell?.textLabel?.textColor = UIColor.green
            }
            
            cell?.textLabel?.text = student.fullName
            cell?.detailTextLabel?.text = "\(student.averageMark)"
            
            return cell!
        }
    }
}
