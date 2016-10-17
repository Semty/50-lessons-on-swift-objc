//
//  ViewController.swift
//  HW22
//
//  Created by Руслан on 17.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

enum PointOfTheHit {
    
    case isWhite, isBlackWithFigure, isBlackWithoutFigure
    
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var whiteTable: UIView!
    @IBOutlet var chessTable: [UIView]!
    @IBOutlet var smallSquadsFirst: [UIView]!
    @IBOutlet var smallSquadsSecond: [UIView]!
    
    var draggingView: UIView?
    var blackSquadForEnding: UIView!
    var touchOffset: CGPoint!
    var lastCenter: CGPoint!
    var centerBlackSquad: CGPoint!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: - Private methods
    
    func viewIsEqualSmallSquad(_ view: UIView?) -> Bool {
        
        if view != nil {
            
            for smallSquad in smallSquadsFirst {
                if smallSquad == view {
                    draggingView = view
                    return true
                }
            }
            
            for smallSquad in smallSquadsSecond {
                if smallSquad == view {
                    draggingView = view
                    return true
                }
            }
        }
        return false
    }
    
    func blackSquadIsClear(_ blackSquad: UIView) -> Bool {
        
        for smallSquad in smallSquadsFirst {
            
            if blackSquad.frame.contains(smallSquad.frame) && smallSquad != draggingView {
                return false
            }
        }
        
        for smallSquad in smallSquadsSecond {
            
            if blackSquad.frame.contains(smallSquad.frame) && smallSquad != draggingView {
                return false
            }
        }
        return true
    }
    
    func pointOfTheHit(_ touch: UITouch, with event: UIEvent) -> PointOfTheHit {
        
        for blackSquad in chessTable {
            
            let pointInsideBlackSquad = touch.location(in: blackSquad)
            
            if blackSquad.point(inside: pointInsideBlackSquad, with: event) {
                
                if blackSquadIsClear(blackSquad) {
                    centerBlackSquad = blackSquad.center
                    return .isBlackWithoutFigure
                } else {
                    return .isBlackWithFigure
                }
            }
        }
        return .isWhite
    }
    
    func nearBlackSquad(using touch: UITouch) -> UIView {
        
        var nearBlackSquad: UIView!
        let pointInWhiteSquad = touch.location(in: whiteTable)
        var distance = Double(Int.max)
        
        for blackSquad in chessTable {
            
            let pointInBlackSquad = blackSquad.center
            
            let dx = pointInBlackSquad.x - pointInWhiteSquad.x
            let dy = pointInBlackSquad.y - pointInWhiteSquad.y
            let dist = Double(dx * dx + dy * dy)
            
            if dist < distance && blackSquadIsClear(blackSquad) {
                nearBlackSquad = blackSquad
                distance = dist
            }
        }
        return nearBlackSquad
    }
    
    func returningToTheLastPosition() {
        
        let animationDuration: TimeInterval = 0.3
        
        UIView.animate(withDuration: animationDuration) { 
            self.draggingView!.center = self.lastCenter
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + animationDuration) { 
            UIView.animate(withDuration: 0.2) {
                self.draggingView!.transform = CGAffineTransform.identity
                self.draggingView!.alpha = 1
                self.draggingView = nil
            }
        }
        
    }
    
    func onTouchesEndedWithTouch(_ touch: UITouch, and event: UIEvent) {
        
        let point = touch.location(in: whiteTable)
        
        if whiteTable.point(inside: point, with: event) {
            let pointOfTheHit = self.pointOfTheHit(touch, with: event)
            if pointOfTheHit == .isBlackWithoutFigure {
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.draggingView!.transform = CGAffineTransform.identity
                                self.draggingView!.alpha = 1
                                self.draggingView!.center = self.centerBlackSquad
                                self.draggingView = nil
                })
            } else if pointOfTheHit == .isBlackWithFigure {
                returningToTheLastPosition()
            } else if pointOfTheHit == .isWhite {
                let toTheBlackSquad = nearBlackSquad(using: touch)
                UIView.animate(withDuration: 0.3,
                               animations: {
                                self.draggingView!.transform = CGAffineTransform.identity
                                self.draggingView!.alpha = 1
                                self.draggingView!.center = toTheBlackSquad.center
                                self.draggingView = nil
                })
            }
            
        } else {
            returningToTheLastPosition()
        }
        
    }

// MARK: - Touches
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first!
        
        let pointOnTheMain = touch.location(in: whiteTable)
        
        let view = whiteTable.hitTest(pointOnTheMain, with: event)
        
        if viewIsEqualSmallSquad(view) {
            
            self.view.bringSubview(toFront: draggingView!)
            
            let touchOffset = touch.location(in: whiteTable)
            
            self.touchOffset = CGPoint(x: draggingView!.frame.midX - touchOffset.x,
                                       y: draggingView!.frame.midY - touchOffset.y)
            
            lastCenter = draggingView!.center
            
            draggingView!.layer.removeAllAnimations()
            
            UIView.animate(withDuration: 0.3, animations: {
                self.draggingView!.transform = self.draggingView!.transform.scaledBy(x: 1.2, y: 1.2)
                self.draggingView!.alpha = 0.75
            })
            
        } else {
            draggingView = nil;
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if self.draggingView != nil {
            
            let touch = touches.first!
            
            let pointOnTheMain = touch.location(in: whiteTable)
            
            let correction = CGPoint(x: pointOnTheMain.x + touchOffset.x,
                                     y: pointOnTheMain.y + touchOffset.y)
            
            draggingView!.center = correction
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.draggingView != nil {
            let touch = touches.first!
            onTouchesEndedWithTouch(touch, and: event!)
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if self.draggingView != nil {
            let touch = touches.first!
            onTouchesEndedWithTouch(touch, and: event!)
        }
    }
}

