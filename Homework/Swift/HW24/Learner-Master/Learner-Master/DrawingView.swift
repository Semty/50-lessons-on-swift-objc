//
//  DrawingView.swift
//  Learner-Master
//
//  Created by Руслан on 23.10.16.
//  Copyright © 2016 Ruslan Timchenko. All rights reserved.
//

import UIKit

class DrawingView: UIView {
    
    private var rects = [CGRect]()

// MARK: - Draw rect
    override func draw(_ rect: CGRect) {
        
        rects = [CGRect]()
        
        for _ in 0..<5 {
            createStarInsideMainRect(rect, with: 4)
        }

    }
// MARK: - Helpful functions
    
    private func randomColor() -> CGColor {
        
        let r = (CGFloat)(arc4random() % 256) / 255
        let g = (CGFloat)(arc4random() % 256) / 255
        let b = (CGFloat)(arc4random() % 256) / 255
        
        return UIColor.init(red: r, green: g, blue: b, alpha: 1).cgColor
    }
    
    private func placeIsFree(forNewRect newRect: CGRect, amongRects rects: [CGRect]) -> Bool {
        
        for currentRect in rects {
            if currentRect.intersects(newRect) {
                return false
            }
        }
        return true
    }

    private func createRandomRect(insideMainRect rect: CGRect, with coeff: CGFloat) -> CGRect {
        
        let size = min(rect.maxX, rect.maxY) / coeff

        var pointX = (CGFloat)(arc4random_uniform((UInt32)(rect.maxX - size * 1.6)))
        var pointY = (CGFloat)(arc4random_uniform((UInt32)(rect.maxY - size * 1.6)))
        var rectOfStar = CGRect(x: pointX, y: pointY, width: size, height: size)
        
        while (placeIsFree(forNewRect: rectOfStar, amongRects: rects) == false) {
            pointX = (CGFloat)(arc4random_uniform((UInt32)(rect.maxX - size * 1.6)))
            pointY = (CGFloat)(arc4random_uniform((UInt32)(rect.maxY - size * 1.6)))
            rectOfStar = CGRect(x: pointX, y: pointY, width: size, height: size)
        }
        
        rects.append(rectOfStar)
        return rectOfStar
    }
    
    private func createStarInsideMainRect(_ mainRect: CGRect, with coeff: CGFloat) {
        
        let rectOfStar = createRandomRect(insideMainRect: mainRect, with: coeff)
        
        let radiusStar = rectOfStar.width / 2
        let centerX = rectOfStar.midX
        let centerY = rectOfStar.midY
        
        let context = UIGraphicsGetCurrentContext()!
        
        var vertexStar = CGPoint()
        let angle = (4.0 * M_PI) / 5.0
        
        context.setLineWidth(2.5)
        context.setStrokeColor(randomColor())
        context.setFillColor(randomColor())
        
        // draw the star
        
        context.move(to: CGPoint(x: centerX, y: centerY - radiusStar))
        
        for tempI in 1..<6 {
            let i = (Double)(tempI)
            vertexStar.x = radiusStar * (CGFloat)(sin(i * angle))
            vertexStar.y = radiusStar * (CGFloat)(cos(i * angle))
            
            context.addLine(to: CGPoint(x: centerX + vertexStar.x, y: centerY - vertexStar.y))
        }
        context.fillPath()
        
        // draw lines
        
        context.setFillColor(randomColor())
        context.move(to: CGPoint(x: centerX, y: centerY - radiusStar))
        
        for tempI in 1..<6 {
            
            let i = (Double)(tempI)
            
            vertexStar.x = radiusStar * (CGFloat)(sin(i * angle / 2))
            vertexStar.y = radiusStar * (CGFloat)(cos(i * angle / 2))
            
            let point = CGPoint(x: centerX + vertexStar.x, y: centerY - vertexStar.y)
            context.addLine(to: point)
            context.setLineCap(.round)
            context.strokePath()
            
            context.move(to: point)
        }
        
        // draw circles
        
        for tempI in 1..<6 {
            
            let i = (Double)(tempI)
            
            vertexStar.x = radiusStar * (CGFloat)(sin(i * angle / 2))
            vertexStar.y = radiusStar * (CGFloat)(cos(i * angle / 2))
            
            let point = CGPoint(x: centerX + vertexStar.x, y: centerY - vertexStar.y)
            let sizeRect = radiusStar / 5
            
            context.addEllipse(in: CGRect(x: point.x - sizeRect / 2,
                                          y: point.y - sizeRect / 2,
                                          width: sizeRect, height: sizeRect))
            context.fillPath()
            
            context.move(to: point)
        }
    }
}















