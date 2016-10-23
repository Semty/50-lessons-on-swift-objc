//
//  DrawingView.swift
//  Superman
//
//  Created by Руслан on 23.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

protocol DrawingViewDelegate {
    
    var lastPoint:  CGPoint  { get set }
    var redColor:   CGFloat  { get set }
    var greenColor: CGFloat  { get set }
    var blueColor:  CGFloat  { get set }
    var opacity:    CGFloat  { get set }
    var lineWidth:  CGFloat  { get set }
}

class DrawingView: UIImageView {

    var delegate: DrawingViewDelegate! = nil
    
// MARK: - Draw rect
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
// MARK: - Helpful functions
    
    func drawLine(from fromPoint: CGPoint, to toPoint: CGPoint) {
        
        let color = UIColor.init(red: self.delegate.redColor,
                                 green: self.delegate.greenColor,
                                 blue: self.delegate.blueColor, alpha: 1).cgColor
        
        var imageRect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageRect = imageRect.integral
        
        UIGraphicsBeginImageContext(self.frame.size) // image begins
        
        let context = UIGraphicsGetCurrentContext()
        self.image?.draw(in: imageRect)
        
        context?.move(to: fromPoint)
        context?.addLine(to: toPoint)
        
        context?.setLineCap(.round)
        context?.setLineWidth(self.delegate.lineWidth)
        context?.setStrokeColor(color)
        context?.setBlendMode(.normal)
        context?.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        self.alpha = self.delegate.opacity
        
        UIGraphicsEndImageContext() // image ends
    }
    
    func merge(tempView: UIImageView, intoMainView mainView: UIImageView) {
        
        UIGraphicsBeginImageContext(mainView.frame.size) // image begins
        
        var imageRect = CGRect(x: 0, y: 0, width: mainView.frame.width, height: mainView.frame.height)
        imageRect = imageRect.integral
        
        mainView.image?.draw(in: imageRect, blendMode: .normal, alpha: 1)
        tempView.image?.draw(in: imageRect, blendMode: .normal, alpha: self.delegate.opacity)
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext() // image ends
        tempView.image = nil
    }
    
    func drawPreview() {
        
        self.image = nil
        
        let color = UIColor.init(red: self.delegate.redColor,
                                 green: self.delegate.greenColor,
                                 blue: self.delegate.blueColor, alpha: 1).cgColor
        
        var imageRect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageRect = imageRect.integral
        
        UIGraphicsBeginImageContext(self.frame.size) // image begins
        
        let context = UIGraphicsGetCurrentContext()
        self.image?.draw(in: imageRect)
        
        context?.move(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
        context?.addLine(to: CGPoint(x: self.bounds.midX, y: self.bounds.midY))
        
        context?.setLineCap(.round)
        context?.setLineWidth(self.delegate.lineWidth)
        context?.setStrokeColor(color)
        context?.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext() // image ends
    }

}
