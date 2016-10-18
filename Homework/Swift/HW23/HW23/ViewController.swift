//
//  ViewController.swift
//  HW23
//
//  Created by Руслан on 18.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var ball: UIImageView!
    let pi: CGFloat = 3.14
    let minus_pi: CGFloat = -3.14
    var ballScale: CGFloat!
    var ballRotation: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tap gesture
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleTap))
        self.view.addGestureRecognizer(tapGesture)
        
        
        // right swipe gesture
        let rightSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleRightSwipe))
        rightSwipeGesture.direction = .right
        self.view.addGestureRecognizer(rightSwipeGesture)
        
        // left swipe gesture
        let leftSwipeGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(handleLeftSwipe))
        leftSwipeGesture.direction = .left
        self.view.addGestureRecognizer(leftSwipeGesture)
        
        
        // double tap gesture
        let doubleTapGesture = UITapGestureRecognizer.init(target: self, action: #selector(handleDoubleTap))
        doubleTapGesture.numberOfTapsRequired = 2
        self.view.addGestureRecognizer(doubleTapGesture)
        
        tapGesture.require(toFail: doubleTapGesture)
        
        
        // pinch gesture
        let pinchGesture = UIPinchGestureRecognizer.init(target: self, action: #selector(handlePinch))
        pinchGesture.delegate = self
        self.view.addGestureRecognizer(pinchGesture)
        
        // rotation gesture
        let rotationGesture = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotation))
        rotationGesture.delegate = self
        self.view.addGestureRecognizer(rotationGesture)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Helpful functions
    
    func rotateView(_ view: UIView, withAngle angle: CGFloat,
                    andAnimationDuration animationDuration: TimeInterval, usingFullCircle fullCircle: Bool) {
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        view.transform = view.transform.rotated(by: angle)
            }) { (true) in
                if fullCircle == true {
                    self.rotateView(view, withAngle: angle, andAnimationDuration: animationDuration, usingFullCircle: false)
                }
        }
    }

// MARK: - Touches
    
    func handleTap(_ tapGesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 2,
                       delay: 0,
                       options: [.allowUserInteraction, .beginFromCurrentState],
                       animations: {
                        self.ball.center = tapGesture.location(in: self.view)
            })
        
    }
    
    func handleRightSwipe(_ rightSwipeGesture: UISwipeGestureRecognizer) {
        rotateView(ball, withAngle: pi, andAnimationDuration: 1, usingFullCircle: true)
    }
    
    func handleLeftSwipe(_ rightSwipeGesture: UISwipeGestureRecognizer) {
        rotateView(ball, withAngle: minus_pi, andAnimationDuration: 1, usingFullCircle: true)
    }
    
    func handleDoubleTap(_ doubleTapGesture: UITapGestureRecognizer) {
        ball.layer.removeAllAnimations()
    }
    
    func handlePinch(_ pinchGesture: UIPinchGestureRecognizer) {
        
        if pinchGesture.state == .began {
            ballScale = 1.0
        }
        
        let scale: CGFloat = 1.0 + pinchGesture.scale - ballScale
        
        ball.transform = ball.transform.scaledBy(x: scale, y: scale)
        
        ballScale = pinchGesture.scale
        
    }
    
    func handleRotation(_ rotationGesture: UIRotationGestureRecognizer) {
        
        if rotationGesture.state == .began {
            ballRotation = 0.0
        }
        
        let rotation = rotationGesture.rotation - ballRotation
        
        ball.transform = ball.transform.rotated(by: rotation)
        
        ballRotation = rotationGesture.rotation
        
    }
    
// MARK: - UIGestureRecognizerDelegate
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

