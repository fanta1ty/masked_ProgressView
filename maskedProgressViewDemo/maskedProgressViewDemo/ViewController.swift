//
//  ViewController.swift
//  maskedProgressViewDemo
//
//  Created by Nguyen Duc Thinh on 11/17/17.
//  Copyright © 2017 Nguyen Duc Thinh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var firstProgressView: UIView!
    @IBOutlet weak var secondProgressView: UIView!
    
    fileprivate var firstMaskedProgressView: maskedProgressView!
    fileprivate var secondMaskedProgressView: maskedProgressView!
    fileprivate var localProgress: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

//MARK: Actions
extension ViewController {
    /** On slider value changed */
    @IBAction func onSliderValueChanged(_ sender: UISlider) {
        var progress = sender.value
        progress = min(max(0, progress), 1)
        firstMaskedProgressView.setProgress(CGFloat(progress), animated: true)
    }
    
    @IBAction func onIncreaseButton(_ sender: Any) {
        localProgress = min(1, localProgress + 0.1)
        secondMaskedProgressView.setProgress(localProgress, animated: true)
    }
    
    @IBAction func onDecreaseButton(_ sender: Any) {
        localProgress = max(0, localProgress - 0.1)
        secondMaskedProgressView.setProgress(localProgress, animated: true)
    }
}

//MARK: Private functions
extension ViewController {
    fileprivate func setupUI() {
        let firstMaskedImage = UIImage(named: "image01")!
        firstMaskedProgressView = maskedProgressView(withFrame: firstProgressView.bounds,
                                                     maskingImage: firstMaskedImage)
        firstMaskedProgressView.setFrontColor(.red)
        firstProgressView.addSubview(firstMaskedProgressView)
        
        let secondMaskedImage = UIImage(named: "image02")!
        secondMaskedProgressView = maskedProgressView(withFrame: secondProgressView.bounds,
                                                      maskingImage: secondMaskedImage)
        secondMaskedProgressView.setFrontColor(.cyan)
        secondProgressView.addSubview(secondMaskedProgressView)
    }
}

