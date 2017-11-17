//
//  maskedProgressView.swift
//  maskedProgressViewDemo
//
//  Created by Nguyen Duc Thinh on 11/17/17.
//  Copyright © 2017 Nguyen Duc Thinh. All rights reserved.
//

import Foundation
import UIKit

class maskedProgressView: UIView {
    //MARK: Properties
    
    /** Animation time */
    var animationTime: CGFloat = 0
    
    /** Gradient layer */
    var gradientLayer: CAGradientLayer!
    
    /** Colors */
    var colors: [UIColor] {
        get {
            var uiColors = [UIColor]()
            
            for color in self.gradientLayer.colors! {
                uiColors.append(UIColor(cgColor: color as! CGColor))
            }
            
            return uiColors
        }
        
        set {
            var cgColors = [CGColor]()
            
            for color in newValue {
                cgColors.append(color.cgColor)
            }
            
            self.gradientLayer.colors = cgColors
        }
    }
    
    /** Back color */
    var backColor: UIColor {
        get {
            return self.colors[0]
        }
        
        set {
            var currentColors = self.colors
            
            if currentColors.count > 0 {
                currentColors[0] = newValue
                self.colors = currentColors
            }
            self.setNeedsDisplay()
        }
    }
    
    /** Front color */
    var frontColor: UIColor {
        get {
            return self.colors[1]
        }
        set {
            var currentColors = self.colors
            
            if currentColors.count > 0 {
                currentColors[1] = newValue
                self.colors = currentColors
            }
            self.setNeedsDisplay()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


//MARK: Functions
extension maskedProgressView {
    static func progressView(withFrame frame: CGRect, maskingImage image: UIImage) -> maskedProgressView {
        return maskedProgressView(withFrame: frame, maskingImage: image)
    }
    
    convenience init(withFrame frame: CGRect, maskingImage image: UIImage) {
        self.init(frame: frame)
        set(maskingImage: image)
    }
    
    func setProgress(_ progress: CGFloat, animated: Bool) {
        let normalizedProgress = 1 - min(max(progress, 0.0), 1.0)
        let normalizedProgressNumber = NSNumber(value: Float(normalizedProgress))
        let newLocations = [normalizedProgressNumber, normalizedProgressNumber]
        
        if animated {
            UIView.animate(withDuration: TimeInterval(animationTime), animations: {
                let animation = CABasicAnimation(keyPath: "locations")
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
                animation.duration = CFTimeInterval(self.animationTime)
                animation.fromValue = self.gradientLayer.locations
                animation.toValue = newLocations
                self.gradientLayer.add(animation, forKey: "animateLocations")
            })
        } else {
            gradientLayer.setNeedsDisplay()
        }
        
        gradientLayer.locations = newLocations
    }
    
    func setProgress(_ progress: CGFloat) {
        setProgress(progress, animated: false)
    }
    
    func setBackColor(_ color: UIColor) {
        backColor = color
    }
    
    func setFrontColor(_ color: UIColor) {
        frontColor = color
    }
    
    func setAnimationTime(_ time: CGFloat) {
        animationTime = time
    }
}

//MARK: Private functions
extension maskedProgressView {
    fileprivate func commonInit() {
        gradientLayer = CAGradientLayer(layer: self.layer)
        gradientLayer.frame = self.bounds
        layer.addSublayer(gradientLayer)
        
        animationTime = 0.5
        setProgress(0)
        colors = [.clear, .red]
        backgroundColor = .clear
    }
    
    fileprivate func set(maskingImage image: UIImage) {
        let cgImageWithAlpha = image.cgImage
        let maskingLayer     = CALayer()
        maskingLayer.contents = cgImageWithAlpha
        
        let layerToBeMasked = self.layer
        layerToBeMasked.mask = maskingLayer
        maskingLayer.frame = layerToBeMasked.bounds
    }
    
    
}
