//
//  TableViewController.swift
//  HW39
//
//  Created by Руслан on 18.12.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Sections: Int {
    
    case pdf
    case web
}

enum pdfRow: Int {
    
    case table
    case reitz
    case berger
}

enum webRow: Int {
    
    case iosDevCourse
    case youtube
    case apple
}

class TableViewController: UITableViewController {
    
// MARK: - Private variables
    
    private var url: URL!
    
// MARK: - Loading of the Programm

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        var urlString = ""
        
        switch indexPath.section {
        case Sections.pdf.rawValue:
            
            switch indexPath.row {
            case pdfRow.table.rawValue:
                urlString = Bundle.main.path(forResource: "pdf_1", ofType: "pdf")!
                url = URL(string: urlString)
                break
            case pdfRow.reitz.rawValue:
                urlString = Bundle.main.path(forResource: "pdf_2", ofType: "pdf")!
                url = URL(string: urlString)
                break
            case pdfRow.berger.rawValue:
                urlString = Bundle.main.path(forResource: "pdf_3", ofType: "pdf")!
                url = URL(string: urlString)
                break
            default:
                break
            }
            break
            
        case Sections.web.rawValue:
            
            switch indexPath.row {
            case webRow.iosDevCourse.rawValue:
                urlString = "https://vk.com/iosdevcourse"
                url = URL(string: urlString)
                break
            case webRow.youtube.rawValue:
                urlString = "https://youtube.com"
                url = URL(string: urlString)
                break
            case webRow.apple.rawValue:
                urlString = "https://apple.com"
                url = URL(string: urlString)
                break
            default:
                break
            }
            break
        default: break
        }
        
        let request = URLRequest(url: url)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        vc.request = request
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
