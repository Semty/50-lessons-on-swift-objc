//
//  ViewController.swift
//  HW31-32
//
//  Created by Руслан on 13.11.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

// MARK: - Immutable identifiers
    
    let cellIdentifier = "cell"
    let firstCellIdentifier = "firstCell"
    let lastCellIdentifier = "lastCell"
    
// MARK: - Mutable variables
    
    var tableView = UITableView()
    var footballLeagues = [[FootballClub]]()
    
// MARK: - Override functions
    
    override func loadView() {
        super.loadView()
        
        let tempTableView = UITableView(frame: self.view.bounds, style: .plain)
        
        tempTableView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        tempTableView.delegate = self
        tempTableView.dataSource = self
        
        self.view.addSubview(tempTableView)
        
        self.tableView = tempTableView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<2 {
            
            var randomLeague = FootballClub.randomFootballLeague()
            sortedByPoints(&randomLeague)
            footballLeagues.append(randomLeague)
        }
        
        self.navigationItem.title = "English Football Leagues"
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(actionEdit))
        self.navigationItem.rightBarButtonItem = editButton
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(actionAdd))
        self.navigationItem.leftBarButtonItem = addButton
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Actions: Edit and Add
    
    func actionEdit(_ sender: UIBarButtonItem) {
        
        let isEditing = self.tableView.isEditing
        
        self.tableView.setEditing(!isEditing, animated: true)
        
        var item = UIBarButtonSystemItem.done
        
        if isEditing {
            item = UIBarButtonSystemItem.edit
        }
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: item,
                                                                 target: self,
                                                                 action: #selector(actionEdit))
        
        prohibitAnyActionsDuringAnimation(with: 0.3)
    }
    
    func actionAdd(_ sender: UIBarButtonItem) {
        
        let league = FootballClub.makeEmptyLeague()
        footballLeagues.insert(league, at: 0)
        
        self.tableView.beginUpdates()
        
        let indexSet = IndexSet.init(integer: 0)
        self.tableView.insertSections(indexSet, with: .automatic)
        
        self.tableView.endUpdates()
        
        prohibitAnyActionsDuringAnimation(with: 0.3)
        
    }
    
// MARK: - Helpful functions
    
    func prohibitAnyActionsDuringAnimation(with time: Double) {
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            
            if UIApplication.shared.isIgnoringInteractionEvents {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
        }
    }
    
    func sortedByPoints(_ array: inout [FootballClub]) {
        
        array = array.sorted { club1, club2 in
            return club1.points > club2.points
        }
    }
    
    func pointsColor(_ points: Int) -> UIColor {
        
        switch points {
        case 0..<30:
            return UIColor.red
        case 0..<60:
            return UIColor.orange
        case 0..<90:
            return UIColor.magenta
        default:
            return UIColor.green
        }
    }
    
    func addFirstCell() -> UITableViewCell {
        
        let firstCell = UITableViewCell(style: .value1, reuseIdentifier: firstCellIdentifier)
        
        firstCell.textLabel?.text = "Tap to add new club"
        firstCell.textLabel?.textColor = UIColor.gray
        firstCell.textLabel?.alpha = 0.85
        
        return firstCell
    }
    
    func addLastCell() -> UITableViewCell {
        
        let lastCell = UITableViewCell(style: .value1, reuseIdentifier: lastCellIdentifier)
        
        lastCell.textLabel?.text = "Tap to delete this league"
        lastCell.textLabel?.textColor = UIColor.gray
        lastCell.textLabel?.alpha = 0.85
        
        return lastCell
    }

// MARK: - UITableViewDataSource
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return footballLeagues[section].count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        
        return footballLeagues.count
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return footballLeagues[section].first?.league
    }
    
//                                                          *** DATA ROWS ***
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            
            var firstCell = tableView.dequeueReusableCell(withIdentifier: firstCellIdentifier)
            
            if firstCell == nil {
                firstCell = addFirstCell()
            }
            return firstCell!
            
        case self.footballLeagues[indexPath.section].endIndex - 1:
            
            var lastCell = tableView.dequeueReusableCell(withIdentifier: lastCellIdentifier)
            
            if lastCell == nil {
                lastCell = addLastCell()
            }
            return lastCell!
            
        default:
            
            var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            
            if cell == nil {
                cell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
            }
            
            let club = footballLeagues[indexPath.section][indexPath.row]
            
            cell?.textLabel?.text = club.name
            cell?.detailTextLabel?.text = "\(club.points)"
            cell?.detailTextLabel?.textColor = pointsColor(club.points)
            
            return cell!
        }
    }
//                                                   -----------------------------
    
//                                                          *** MOVING ROWS ***

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return indexPath.row != 0 && indexPath.row != footballLeagues[indexPath.section].endIndex - 1
    }
    
    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var tempLeague = footballLeagues[sourceIndexPath.section]
        let sourceClub = tempLeague[sourceIndexPath.row]
        
        if sourceIndexPath.section == destinationIndexPath.section {
            
            tempLeague.remove(at: sourceIndexPath.row)
            tempLeague.insert(sourceClub, at: destinationIndexPath.row)
            footballLeagues[sourceIndexPath.section] = tempLeague
            
        } else {
            
            tempLeague.remove(at: sourceIndexPath.row)
            footballLeagues[sourceIndexPath.section] = tempLeague
            
            tempLeague = footballLeagues[destinationIndexPath.section]
            sourceClub.league = (tempLeague.first?.league)!
            tempLeague.insert(sourceClub, at: destinationIndexPath.row)
            footballLeagues[destinationIndexPath.section] = tempLeague
        }
        
        self.tableView.reloadData()
    }
//                                                   -----------------------------
    
//                                                          *** DELETE ROWS ***
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle,
                          forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            var footballLeague = footballLeagues[indexPath.section]
            
            footballLeague.remove(at: indexPath.row)
            footballLeagues[indexPath.section] = footballLeague
        }
        
        self.tableView.beginUpdates()
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        self.tableView.endUpdates()
    }
//                                                   -----------------------------
    
// MARK: - UITableViewDelegate
    
    public func tableView(_ tableView: UITableView,
                                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return (indexPath.row != 0 && indexPath.row != footballLeagues[indexPath.section].endIndex - 1) ? .delete : .none
    }
    
    public func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    public func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt
                sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        if proposedDestinationIndexPath.row == 0 ||
           proposedDestinationIndexPath.row == footballLeagues[proposedDestinationIndexPath.section].endIndex - 1 {
            return sourceIndexPath
        } else {
            return proposedDestinationIndexPath
        }
    }
//                                                          *** ADDING ROWS ***
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            
            var tempLeague = footballLeagues[indexPath.section]
            let newFootballClub = FootballClub.randomFootballClub()
            
            tempLeague.insert(newFootballClub, at: 1)
            footballLeagues[indexPath.section] = tempLeague
            
            self.tableView.beginUpdates()
            let startIndexPath = IndexPath(row: 1, section: indexPath.section)
            self.tableView.insertRows(at: [startIndexPath], with: .automatic)
            self.tableView.endUpdates()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: { 
                
                self.sortedByPoints(&tempLeague)
                self.footballLeagues[indexPath.section] = tempLeague
                
                self.tableView.beginUpdates()
                let endIndexPath = IndexPath(row: tempLeague.index(of: newFootballClub)!, section: indexPath.section)
                self.tableView.moveRow(at: startIndexPath, to: endIndexPath)
                self.tableView.endUpdates()
    
            })
            self.prohibitAnyActionsDuringAnimation(with: 1.0)
//                                                   -----------------------------
            
//                                                          *** DELETE SECTIONS ***
        } else if indexPath.row == footballLeagues[indexPath.section].endIndex - 1 {
            
            footballLeagues.remove(at: indexPath.section)
            
            self.tableView.beginUpdates()
            let newIndexSet = IndexSet.init(integer: indexPath.section)
            self.tableView.deleteSections(newIndexSet, with: .automatic)
            self.tableView.endUpdates()
            
        }
        
    }

}
