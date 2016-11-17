//
//  DirectoryViewController.swift
//  HW33-34
//
//  Created by Руслан on 17.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class DirectoryViewController: UITableViewController {
    
// MARK: - Public variables
    
    var path: String! {
        
        willSet(newPath) {
            
            self.path = newPath
            
            do {
                contents = try FileManager.default.contentsOfDirectory(atPath: newPath)
                
                self.tableView.reloadData()
                self.navigationItem.title = newPath.lastPathComponent
            } catch let error as NSError {
                print("\n\n\n\(error.localizedDescription)\n\n")
            }
        }
    }
    
    var contents = [String]()
    
// MARK: - Private variables
    
    private let addCellIdentifier = "addCellIdentifier"
    
    private var selectedPath = ""
    private var files = [String]()
    private var folders = [String]()
    
// MARK: - Initialization
    
    init(with path: String) {
        self.path = path
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
// MARK: - Load of the programm

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.path == nil {
            self.path = "/Users/ruslan/Desktop/iOSDevCourse"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        sortCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if self.navigationController?.viewControllers.count == 1 {
            self.navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Actions
    
    @IBAction func actionToRoot(_ sender: UIBarButtonItem) {
        
        _ = (self.navigationController?.popToRootViewController(animated: true))!
    }
    
    @IBAction func actionEdit(_ sender: UIBarButtonItem) {
        
        if contents.first ?? "zero" != addCellIdentifier {
            
            self.tableView.beginUpdates()
            let indexPath = IndexPath(row: 0, section: 0)
            
            insertAddCellToTableView()
            
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            self.tableView.endUpdates()
            
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(actionEdit(_:)))
            let rightButtons = [self.navigationItem.rightBarButtonItem!, cancelButton]
            
            self.navigationItem.rightBarButtonItems = rightButtons
            
            self.tableView.setEditing(true, animated: true)
            punishToTapDuringAnimation()
            
        } else {
            deleteAddCellOfTableView()
        }
    }
    
// MARK: Helpful functions
    
    func sortCells() {
        for (index, item) in contents.enumerated() {
            
            if isDirectoryAtIndexPath(IndexPath(row: index, section: 0)) {
                folders.append(item)
            } else {
                files.append(item)
            }
        }
        
        folders = folders.sorted()
        files = files.sorted()
        
        contents.removeAll()
        contents.append(contentsOf: folders)
        contents.append(contentsOf: files)
        
        folders.removeAll()
        files.removeAll()
    }
    
    func formatDate(from attributes: [FileAttributeKey: Any]) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YY"
        
        return formatter.string(from: attributes[FileAttributeKey.creationDate] as! Date)
    }
    
    func folderSize(from folderPath: String) -> String {
        
        let files = FileManager.default.subpaths(atPath: folderPath)
        
        var folderSize = 0
        
        for fileName in files! {
            
            let path = folderPath.stringByAppendingPathComponent(path: fileName)
            do {
                let attributes = try FileManager.default.attributesOfItem(atPath: path)
                folderSize += attributes[FileAttributeKey.size] as! Int
            } catch let error as NSError {
                print("\n\n\n\(error.localizedDescription)\n\n")
            }
            
        }
        return fileSize(from: folderSize)
    }
    
    func fileSize(from size: Int) -> String {
        
        let units = ["B", "KB", "MB", "GB", "TB"]
        
        var index = 0
        var fileSize = (Double)(size)
        
        while fileSize > 1024 && index < units.count {
            fileSize /= 1024
            index += 1
        }
        return "\((Int)(fileSize)) \(units[index])"
    }
    
    func isHiddenAtIndexPathRow(_ row: Int) -> Bool {
        
        let item = contents[row]
        print(item, " = \(item.characters.first!)")
        
        if item.characters.first! == "." {
            return true
        } else {
            return false
        }
    }
    
    func punishToTapDuringAnimation() {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if UIApplication.shared.isIgnoringInteractionEvents {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
        })
    }
    
    func isDirectoryAtIndexPath(_ indexPath: IndexPath) -> Bool {
        
        var isDirectory = (ObjCBool)(false)
        
        let fileName = contents[indexPath.row]
        let filePath = self.path.stringByAppendingPathComponent(path: fileName)
        
        FileManager.default.fileExists(atPath: filePath, isDirectory: &isDirectory)
        
        return isDirectory.boolValue
    }
    
    func insertAddCellToTableView() {
        self.contents.insert(addCellIdentifier, at: 0)
    }
    
    func deleteAddCellOfTableView() {
        
        self.tableView.beginUpdates()
        let indexPath = IndexPath(row: 0, section: 0)
        
        self.contents.remove(at: 0)
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        self.tableView.endUpdates()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit(_:)))
        let rightButtons = [self.navigationItem.rightBarButtonItem!, editButton]
        
        self.navigationItem.rightBarButtonItems = rightButtons
        
        self.tableView.setEditing(false, animated: true)
        punishToTapDuringAnimation()
    }
    

// MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let folderIdentifier = "folderIdentifier"
        let fileIdentifier = "fileIdentifier"
        let fileName = contents[indexPath.row]
        var attributes = [FileAttributeKey: Any]()
        
        do {
            attributes = try FileManager.default.attributesOfItem(atPath:
                self.path.stringByAppendingPathComponent(path: fileName))
        } catch let error as NSError {
            print("\n\n\n\(error.localizedDescription)\n\n")
        }
        
        if isDirectoryAtIndexPath(indexPath) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: folderIdentifier) as! FolderCell
            
            if isHiddenAtIndexPathRow(indexPath.row) {
                cell.folderImage.alpha = 0.4
                cell.nameLabel.alpha = 0.4
            }
            cell.nameLabel.text = fileName
            cell.folderSizeLabel.text = folderSize(from: self.path.stringByAppendingPathComponent(path: fileName))
            cell.dateLabel.text = formatDate(from: attributes)
            
            return cell
            
        } else if fileName != addCellIdentifier {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: fileIdentifier) as! FileCell
            
            if isHiddenAtIndexPathRow(indexPath.row) {
                cell.fileImage.alpha = 0.4
                cell.nameLabel.alpha = 0.4
            }
            cell.nameLabel.text = fileName
            cell.fileSizeLabel.text = fileSize(from: attributes[FileAttributeKey.size] as! Int)
            cell.dateLabel.text = formatDate(from: attributes)
            
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: addCellIdentifier) as! AddCell
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return contents[indexPath.row] != addCellIdentifier
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let fileName = contents[indexPath.row]
            let filePath = self.path.stringByAppendingPathComponent(path: fileName)
            
            let alert = UIAlertController(title: "Are you sure?", message: nil,
                                          preferredStyle: .alert)
            
            let actionYes = UIAlertAction(title: "Yes", style: .destructive, handler: { (UIAlertAction) in
                
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    
                    self.contents.remove(at: indexPath.row)
                    
                    do {
                        try FileManager.default.removeItem(atPath: filePath)
                    } catch let error as NSError {
                        print("\n\n\n\(error.localizedDescription)\n\n")
                    }
                    tableView.deleteRows(at: [indexPath], with: .fade)
                })
            })
            
            let actionNo = UIAlertAction(title: "No", style: .cancel, handler: { (UIAlertAction) in
                
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    
                    self.tableView.setEditing(false, animated: true)
                    
                    if self.contents[0] == self.addCellIdentifier {
                        self.deleteAddCellOfTableView()
                    }
                })
            })
            
            alert.addAction(actionNo)
            alert.addAction(actionYes)
            self.present(alert, animated: true, completion: nil)
        }
    }

// MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "NewFolderViewController" {
            deleteAddCellOfTableView()
        }
        
    }
    
// MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        let filePath = self.path.stringByAppendingPathComponent(path: contents[indexPath.row])
        
        if isDirectoryAtIndexPath(indexPath) {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "DirectoryViewController") as! DirectoryViewController
            vc.path = filePath
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return contents[indexPath.row] == addCellIdentifier ? 44 : 70
    }

}
