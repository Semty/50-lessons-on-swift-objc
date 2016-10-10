//
//  ViewController.swift
//  HW19
//
//  Created by Руслан on 10.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var squads = UIView()
    var blackSquads = [UIView]()
    var smallSquads = [UIView]()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chessBlackSquad = UIView.init(frame: CGRect(x: 0, y: (view.frame.size.height - view.frame.size.width) / 2,
                                                        width: view.frame.size.width, height: view.frame.size.width))
        chessBlackSquad.backgroundColor = UIColor.black
        chessBlackSquad.autoresizingMask = [.flexibleBottomMargin, .flexibleTopMargin,
                                            .flexibleLeftMargin, .flexibleRightMargin]
        self.view.addSubview(chessBlackSquad)
        
        
        let chessWhiteSquad = UIView.init(frame: CGRect(x: chessBlackSquad.bounds.origin.x + 2,
                                                        y: chessBlackSquad.bounds.origin.y + 2,
                                                        width: chessBlackSquad.bounds.size.width - 4,
                                                        height: chessBlackSquad.bounds.size.width - 4))
        chessWhiteSquad.backgroundColor = UIColor.white
        chessBlackSquad.addSubview(chessWhiteSquad)
        squads = chessWhiteSquad
        
        for i: UInt in 0..<8 {
            
            if i % 2 == 0 {
                createChessColumnWith(rowIndex: i, andColumnIndex: 0)
            } else {
                createChessColumnWith(rowIndex: i, andColumnIndex: 1)
            }
            
        }
        
    }
    
// MARK: - Helpful functions
    
    func createChessColumnWith(rowIndex row: UInt, andColumnIndex column: UInt) {
        
        var j = column
        
        while j < 8 {
            let blackSquad = UIView.init(frame: CGRect(x: 1 + (squads.frame.size.width - 2) / 8 * CGFloat(row),
                                                       y: 1 + (squads.frame.size.height - 2) / 8 * CGFloat(j),
                                                       width: (squads.frame.size.width - 2) / 8,
                                                       height: (squads.frame.size.height - 2) / 8))
            blackSquad.backgroundColor = UIColor.black
            squads.addSubview(blackSquad)
            blackSquads.append(blackSquad)
            
            if j != 3 && j != 4 {
                
                let smallSquad = UIView.init(frame: CGRect(x: blackSquad.frame.origin.x + blackSquad.frame.size.width / 4,
                                                           y: blackSquad.frame.origin.y + blackSquad.frame.size.height / 4,
                                                           width: (squads.frame.size.width - 2) / 16,
                                                           height: (squads.frame.size.height - 2) / 16))
                smallSquad.backgroundColor = UIColor.yellow
                squads.addSubview(smallSquad)
                smallSquads.append(smallSquad)
                
            }
            j += 2
        }
    }
    
    func changeColorOfSquads() {
        
        var randomColor: UIColor!
        
        switch arc4random() % 8 {
        case 0:
            randomColor = .orange
        case 1:
            randomColor = .green
        case 2:
            randomColor = .red
        case 3:
            randomColor = .blue
        case 4:
            randomColor = .purple
        case 5:
            randomColor = .lightGray
        case 6:
            randomColor = .magenta
        case 7:
            randomColor = .black
        default:
            break
        }
        
        for squad in blackSquads {
            squad.backgroundColor = randomColor
        }
        
        for squad in smallSquads {
            
            var i = arc4random() % UInt32(smallSquads.count)
            while i == UInt32(smallSquads.index(of: squad)!) {
                i = arc4random() % UInt32(smallSquads.count)
            }
            
            let anotherSmallSquad = smallSquads[Int(i)]
            let tempFrameSquadOfI = anotherSmallSquad.frame
            let tempFrameSquad = squad.frame
            
            UIView.animate(withDuration: 1.5, animations: {
                
                squad.frame = tempFrameSquadOfI
                anotherSmallSquad.frame = tempFrameSquad
                self.squads.bringSubview(toFront: squad)
                self.squads.bringSubview(toFront: self.smallSquads[Int(i)])
                
            })
        }
    }
    
// MARK: - Rotate device
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        changeColorOfSquads()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

