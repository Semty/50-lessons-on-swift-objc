//
//  ViewController.swift
//  HW20
//
//  Created by Руслан on 13.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }
    
    @IBOutlet var blackSquads: [UIView]!
    @IBOutlet var smallSquadsFirst: [UIView]!
    @IBOutlet var smallSquadsSecond: [UIView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func randomColor() -> UIColor {
        
        let r = (Float)(arc4random() % 256) / 255;
        let g = (Float)(arc4random() % 256) / 255;
        let b = (Float)(arc4random() % 256) / 255;
        
        let randomColor = UIColor.init(colorLiteralRed: r, green: g, blue: b, alpha: 1)
        return randomColor
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
        let randomColor = self.randomColor()
        
        for blackSquad in blackSquads {
            blackSquad.backgroundColor = randomColor
        }
        
        for i in 0..<smallSquadsFirst.count {
            
            let smallSquad1 = smallSquadsFirst[i]
            let smallSquad2 = smallSquadsSecond[i]
            
            let smallSquadFrame1 = smallSquad1.frame
            let smallSquadFrame2 = smallSquad2.frame
            
            UIView.animate(withDuration: 1, animations: {
                
                smallSquad1.frame = smallSquadFrame2
                smallSquad2.frame = smallSquadFrame1
                
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

