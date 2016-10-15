//
//  ViewController.swift
//  HW21
//
//  Created by Руслан on 15.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var squad1: UIView!
    @IBOutlet weak var squad2: UIView!
    @IBOutlet weak var squad3: UIView!
    @IBOutlet weak var squad4: UIView!
    
    @IBOutlet weak var squad5: UIView!
    @IBOutlet weak var squad6: UIView!
    @IBOutlet weak var squad7: UIView!
    @IBOutlet weak var squad8: UIView!
    
    @IBOutlet weak var blackSquad: UIView!
    @IBOutlet weak var runner: UIImageView!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .all
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = UIImage.init(named: "png_1")
        let image2 = UIImage.init(named: "png_2")
        let image3 = UIImage.init(named: "png_3")
        let image4 = UIImage.init(named: "png_4")
        let image5 = UIImage.init(named: "png_5")
        let image6 = UIImage.init(named: "png_6")
        let image7 = UIImage.init(named: "png_7")
        let image8 = UIImage.init(named: "png_8")
        let image9 = UIImage.init(named: "png_9")
        let image10 = UIImage.init(named: "png_10")
        
        let images = [ image1!, image2!, image3!, image4!, image5!, image6!, image7!, image8!, image9!, image10! ]
        
        runner.animationDuration = 0.75
        runner.transform = runner.transform.rotated(by: 135)
        runner.animationImages = images
        
    }
    
    func moveRunner() {
        
        let animationDuration = 1.25
        let leftTopAngle = runner.center
        let rightTopAngle = CGPoint(x: self.blackSquad.bounds.width - self.runner.center.x,
                                 y: self.runner.center.y)
        let rightBottomAngle = CGPoint(x: self.blackSquad.bounds.width - self.runner.center.x,
                                       y: self.blackSquad.bounds.height - self.runner.center.y)
        let leftBottomAngle = CGPoint(x: leftTopAngle.x,
                                      y: self.blackSquad.bounds.height - self.runner.center.y)
        
        let r1 = runner.transform.rotated(by: 0)
        let r2 = runner.transform.rotated(by: 90)
        let r3 = runner.transform.rotated(by: 135)
        let r4 = runner.transform.rotated(by: 225)
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.runner.center = rightTopAngle
        }) { (true) in
            self.runner.transform = r2
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.runner.center = rightBottomAngle
            }) { (true) in
                self.runner.transform = r3
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 2) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.runner.center = leftBottomAngle
            }) { (true) in
                self.runner.transform = r4
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration * 3) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.runner.center = leftTopAngle
            }) { (true) in
                self.runner.transform = r1
                self.moveRunner()
            }
        }
        
    }
    
    func moveAngleSquads() {
        
        let squad5Center = squad5.center
        let squad6Center = squad6.center
        let squad7Center = squad7.center
        let squad8Center = squad8.center
        
        let squad5Color = squad5.backgroundColor
        let squad6Color = squad6.backgroundColor
        let squad7Color = squad7.backgroundColor
        let squad8Color = squad8.backgroundColor
        
        let animationDuration: TimeInterval = 2
        let r = CGFloat(arc4random() % UInt32(360))
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.squad5.transform = self.squad5.transform.rotated(by: r)
                        self.squad5.backgroundColor = squad6Color!
                        self.squad5.center = squad6Center
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.squad6.transform = self.squad6.transform.rotated(by: r)
                            self.squad6.backgroundColor = squad7Color!
                            self.squad6.center = squad7Center
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.squad7.transform = self.squad7.transform.rotated(by: r)
                            self.squad7.backgroundColor = squad8Color!
                            self.squad7.center = squad8Center
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.squad8.transform = self.squad8.transform.rotated(by: r)
                            self.squad8.backgroundColor = squad5Color!
                            self.squad8.center = squad5Center
                },
                           completion: { (true) in
                            self.moveAngleSquads()
            })
        }
    }
    
    func moveSquads() {
        
        let animationDuration = 3.0;
        let animationLength = view.bounds.maxX - squad1.frame.width - squad1.frame.origin.x
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: [.curveEaseInOut, .autoreverse, .repeat],
                       animations: {
                        self.squad1.frame = CGRect(x: animationLength,
                                              y: self.squad1.frame.origin.y,
                                              width: self.squad1.frame.width,
                                              height: self.squad1.frame.height);
        })
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: [.curveEaseIn, .autoreverse, .repeat],
                           animations: {
                            self.squad2.frame = CGRect(x: animationLength,
                                                       y: self.squad2.frame.origin.y,
                                                       width: self.squad2.frame.width,
                                                       height: self.squad2.frame.height);
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: [.curveEaseOut, .autoreverse, .repeat],
                           animations: {
                            self.squad3.frame = CGRect(x: animationLength,
                                                       y: self.squad3.frame.origin.y,
                                                       width: self.squad3.frame.width,
                                                       height: self.squad3.frame.height);
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: animationDuration,
                           delay: 0,
                           options: [.curveLinear, .autoreverse, .repeat],
                           animations: {
                            self.squad4.frame = CGRect(x: animationLength,
                                                       y: self.squad4.frame.origin.y,
                                                       width: self.squad4.frame.width,
                                                       height: self.squad4.frame.height);
            })
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        moveSquads()
        moveAngleSquads()
        runner.startAnimating()
        moveRunner()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

