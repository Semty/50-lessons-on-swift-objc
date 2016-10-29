//
//  ViewController.swift
//  HW26
//
//  Created by Руслан on 29.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum Animal: Int {
    
    case po
    case tigress
    case shifu
    
}

enum Direction: Int {
    
    case up
    case down
    
}

class ViewController: UIViewController {
    
// MARK: - Storyboard Properties
    
    @IBOutlet weak var draggingView: UIImageView!
    
    @IBOutlet weak var rotationSwitch: UISwitch!
    @IBOutlet weak var scaleSwitch: UISwitch!
    @IBOutlet weak var translationSwitch: UISwitch!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var speedAnimationLabel: UILabel!
    @IBOutlet weak var speedAnimationSlider: UISlider!
    
// MARK: - Private properties
    
    private var isAnimation = false
    private var speedAnimation: TimeInterval = 1

// MARK: - viewDidLoad and didReceiveMemoryWarning
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - Private mathods
    
    func move(to point: Direction) -> CGPoint {
        
        switch point {
        case .up:
            return CGPoint(x: self.draggingView.bounds.origin.x,
                           y: self.draggingView.bounds.origin.y + 0.23 * self.draggingView.bounds.height)
        case .down:
            return CGPoint(x: self.draggingView.bounds.origin.x,
                           y: self.draggingView.bounds.origin.y - 0.23 * self.draggingView.bounds.height)
        }
    }
    
    func transformDraggingView() {
        
        self.isAnimation = true
        
        var transform = CGAffineTransform.init(translationX: self.draggingView.bounds.origin.x,
                                                            y: self.draggingView.bounds.origin.y)
        transform = transform.rotated(by: 0)
        transform = transform.scaledBy(x: 1, y: 1)
        
        if self.translationSwitch.isOn {
            let point = move(to: Direction(rawValue: (Int)(arc4random()%2))!)
            transform = transform.translatedBy(x: point.x, y: point.y)
        }
        
        if self.rotationSwitch.isOn {
            transform = transform.rotated(by: CGFloat(M_PI))
        }
        
        if self.scaleSwitch.isOn {
            transform = transform.scaledBy(x: 1.25, y: 1.25)
        }
        
        UIView.animate(withDuration: self.speedAnimation,
                       delay: 0,
                       options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState],
                       animations: { self.draggingView.transform = transform },
                       completion: ({(true) in
                        
                        UIView.animate(withDuration: self.speedAnimation,
                                       delay: 0,
                                       options: [.curveLinear, .allowUserInteraction, .beginFromCurrentState],
                                       animations: { self.draggingView.transform = CGAffineTransform.identity },
                                       completion: ({(true) in
                                        
                                        if self.scaleSwitch.isOn || self.rotationSwitch.isOn || self.translationSwitch.isOn {
                                            self.transformDraggingView()
                                        } else {
                                            self.isAnimation = false
                                        }
                                        
                                       }))
                        }))
    }
    
    func changeImage(_ animal: Animal) {
        
        switch animal {
        case .po:
            self.draggingView.image = UIImage.init(named: "Po.jpg")
        case .tigress:
            self.draggingView.image = UIImage.init(named: "Tigress.jpg")
        case .shifu:
            self.draggingView.image = UIImage.init(named: "Shifu.jpg")
        }
        
    }
    
// MARK: - Actions
    
    @IBAction func actionSegmentedControl(_ sender: UISegmentedControl) {
        changeImage(Animal(rawValue: sender.selectedSegmentIndex) ?? Animal.po)
    }
    
    @IBAction func actionSlider(_ sender: UISlider) {
        self.speedAnimation = TimeInterval(self.speedAnimationSlider.value)
        self.speedAnimationLabel.text = String.init(format: "%1.1f", self.speedAnimation)
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        if !self.isAnimation {
            transformDraggingView()
        }
    }

}

