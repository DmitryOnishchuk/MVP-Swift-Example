//
//  UIView+Extension.swift
//  MVP-Swift-Example
//
//  Created by Dmitry Onishchuk on 28.07.2022.
//  Copyright © 2022 Dmitry Onishchuk. All rights reserved.
//

import UIKit

extension UIView {
    
    func shadow(color: UIColor = UIColor.black,
                offset: CGSize = CGSize(width: 0, height: 1),
                opacity: Float = 0.2,
                radius: CGFloat = 2){
        self.layer.shadowRadius = radius
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
    
    func removeShadow() {
        self.layer.shadowColor = nil
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0
        self.layer.shadowRadius = 0
    }
    
    func roundCorners(radius: CGFloat = 10, corners: UIRectCorner = .allCorners) {
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            var arr: CACornerMask = []
            
            let allCorners: [UIRectCorner] = [.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
            
            for corn in allCorners {
                if(corners.contains(corn)){
                    switch corn {
                    case .topLeft:
                        arr.insert(.layerMinXMinYCorner)
                    case .topRight:
                        arr.insert(.layerMaxXMinYCorner)
                    case .bottomLeft:
                        arr.insert(.layerMinXMaxYCorner)
                    case .bottomRight:
                        arr.insert(.layerMaxXMaxYCorner)
                    case .allCorners:
                        arr.insert(.layerMinXMinYCorner)
                        arr.insert(.layerMaxXMinYCorner)
                        arr.insert(.layerMinXMaxYCorner)
                        arr.insert(.layerMaxXMaxYCorner)
                    default: break
                    }
                }
            }
            self.layer.maskedCorners = arr
        } else {
            self.roundCornersBezierPath(corners: corners, radius: radius)
        }
    }
    
    private func roundCornersBezierPath(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func linearGradientBackground(angleInDegs: Int, colors: [CGColor], locations: [NSNumber]? = nil) {
        let gradientBaseLayer: CAGradientLayer = CAGradientLayer()
        gradientBaseLayer.frame = self.bounds
        gradientBaseLayer.colors = colors
        gradientBaseLayer.locations = locations
        gradientBaseLayer.startPoint = startAndEndPointsFrom(angle: angleInDegs).startPoint
        gradientBaseLayer.endPoint = startAndEndPointsFrom(angle: angleInDegs).endPoint
        gradientBaseLayer.name = "gradient"
        
        self.layer.sublayers?.filter {
            $0.name == gradientBaseLayer.name
        }.forEach {
            $0.removeFromSuperlayer()
        }
        
        self.layer.insertSublayer(gradientBaseLayer, at: 0)
    }
    
    func changeAnimationGradientBackground(newColors: [CGColor], duration: CFTimeInterval = 0.5, animationDelegate: CAAnimationDelegate){
        
        var currentGradientLayer:CAGradientLayer!
        
        self.layer.sublayers?.filter {
            $0.name == "gradient"
        }.forEach {
            currentGradientLayer = $0 as? CAGradientLayer
        }
        if currentGradientLayer == nil { return }
        
        //currentGradientLayer.removeAllAnimations()
        
        let colorsAnimation = CABasicAnimation(keyPath: #keyPath(CAGradientLayer.colors))
        colorsAnimation.fromValue = currentGradientLayer.colors
        colorsAnimation.toValue = newColors
        colorsAnimation.duration = duration
        colorsAnimation.delegate = animationDelegate
        colorsAnimation.fillMode = .forwards
        colorsAnimation.isRemovedOnCompletion = false
        currentGradientLayer.add(colorsAnimation, forKey: "colorsAnimation")
    }
    
    func startAndEndPointsFrom(angle: Int) -> (startPoint:CGPoint, endPoint:CGPoint) {
        var startPointX:CGFloat = 0.5
        var startPointY:CGFloat = 1.0
        
        var startPoint:CGPoint
        var endPoint:CGPoint
        
        switch true {
        case angle == 0:
            startPointX = 0.5
            startPointY = 1.0
        case angle == 45:
            startPointX = 0.0
            startPointY = 1.0
        case angle == 90:
            startPointX = 0.0
            startPointY = 0.5
        case angle == 135:
            startPointX = 0.0
            startPointY = 0.0
        case angle == 180:
            startPointX = 0.5
            startPointY = 0.0
        case angle == 225:
            startPointX = 1.0
            startPointY = 0.0
        case angle == 270:
            startPointX = 1.0
            startPointY = 0.5
        case angle == 315:
            startPointX = 1.0
            startPointY = 1.0
            
        case angle > 315 || angle < 45:
            startPointX = 0.5 - CGFloat(tan(angle.degreesToRads()) * 0.5)
            startPointY = 1.0
        case angle > 45 && angle < 135:
            startPointX = 0.0
            startPointY = 0.5 + CGFloat(tan(90.degreesToRads() - angle.degreesToRads()) * 0.5)
        case angle > 135 && angle < 225:
            startPointX = 0.5 - CGFloat(tan(180.degreesToRads() - angle.degreesToRads()) * 0.5)
            startPointY = 0.0
        case angle > 225 && angle < 359:
            startPointX = 1.0
            startPointY = 0.5 - CGFloat(tan(270.degreesToRads() - angle.degreesToRads()) * 0.5)
        default: break
        }
        
        startPoint = CGPoint(x: startPointX, y: startPointY)
        endPoint = startPoint.opposite()
        return (startPoint, endPoint)
    }
    
    func fadeTo(_ alpha: CGFloat, duration: TimeInterval = 0.1, async: Bool = false, complete: ((_ finish: Bool) -> Void)? = nil) {
        if async {
            DispatchQueue.main.async {
                UIView.animate(withDuration: duration, animations: {
                    self.alpha = alpha
                }, completion: complete)
            }
        }else{
            UIView.animate(withDuration: duration, animations: {
                self.alpha = alpha
            }, completion: complete)
        }
    }
    
    func fadeIn(_ duration: TimeInterval = 0.1, async: Bool = false, complete: ((_ finish: Bool) -> Void)? = nil) {
        if self.alpha != 1.0 {
            fadeTo(1.0, duration: duration, async: async, complete: complete)
        }
    }
    
    func fadeOut(_ duration: TimeInterval = 0.1, async: Bool = false, complete: ((_ finish: Bool) -> Void)? = nil) {
        if self.alpha != 0.0 {
            fadeTo(0.0, duration: duration, async: async, complete: complete)
        }
    }
    
    func setRedBorder(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
    }
    
    func setYellowBorder(){
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor
    }
}
