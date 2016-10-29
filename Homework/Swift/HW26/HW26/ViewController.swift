//
//  ViewController.swift
//  HW26
//
//  Created by Руслан on 29.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var draggingView: UIImageView!
    
    @IBOutlet weak var rotationSwitch: UISwitch!
    @IBOutlet weak var scaleSwitch: UISwitch!
    @IBOutlet weak var translationSwitch: UISwitch!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var speedAnimationLabel: UILabel!
    @IBOutlet weak var speedAnimationSlider: UISlider!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

