//
//  GradientView.swift
//  Travanada2
//
//  Created by Pawan Dey on 17/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

//@IBDesignable
//class GradientView: UIView {
//    var FirstColor: UIColor = UIColor.clear{
//        didSet{
//            updateView()
//        }
//    }
//    var SecondColor: UIColor = UIColor.clear{
//        didSet{
//            updateView()
//        }
//    }
//    override class var layerClass: AnyClass{
//        get {
//            return CAGradientLayer.self
//        }
//    }
//    func updateView(){
//        let layer = self.layer as! CAGradientLayer
//        layer.colors = [ FirstColor.cgColor, SecondColor.cgColor]
//    }
//    
//    
//}

//
//
//@IBDesignable
//class GradientButton: UIButton {
//    let gradientLayer = CAGradientLayer()
//
//    @IBInspectable
//    var topGradientColor: UIColor? {
//        didSet {
//            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//        }
//    }
//
//    @IBInspectable
//    var bottomGradientColor: UIColor? {
//        didSet {
//            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
//        }
//    }
//
//    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
//        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
//            gradientLayer.frame = bounds
//            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
//            gradientLayer.borderColor = layer.borderColor
//            gradientLayer.borderWidth = layer.borderWidth
//            gradientLayer.cornerRadius = layer.cornerRadius
//            layer.insertSublayer(gradientLayer, at: 0)
//        } else {
//            gradientLayer.removeFromSuperlayer()
//        }
//    }
//}
//


@IBDesignable
class KButton: UIButton {
    
    // MARK: - IBInspectable properties
    /// Renders vertical gradient if true else horizontal
    @IBInspectable public var verticalGradient: Bool = true {
        didSet {
            updateUI()
        }
    }
    
    /// Start color of the gradient
    @IBInspectable public var startColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /// End color of the gradient
    @IBInspectable public var endColor: UIColor = .clear {
        didSet {
            updateUI()
        }
    }
    
    /// Border color of the view
    @IBInspectable public var borderColor: UIColor? = nil {
        didSet {
            updateUI()
        }
    }
    
    /// Border width of the view
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    /// Corner radius of the view
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - Variables
    /// Closure is called on click event of the button
    public var onClick = { () }
    
    private var gradientlayer = CAGradientLayer()
    
    // MARK: - init methods
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - Layout
    override public func layoutSubviews() {
        super.layoutSubviews()
        updateFrame()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        gradientlayer = CAGradientLayer()
        updateUI()
        layer.addSublayer(gradientlayer)
    }
    
    // MARK: - Update frame
    private func updateFrame() {
        gradientlayer.frame = bounds
    }
    
    // MARK: - Update UI
    private func updateUI() {
        addTarget(self, action: #selector(clickAction(button:)), for: UIControlEvents.touchUpInside)
        gradientlayer.colors = [startColor.cgColor, endColor.cgColor]
        if verticalGradient {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 0, y: 1)
        } else {
            gradientlayer.startPoint = CGPoint(x: 0, y: 0)
            gradientlayer.endPoint = CGPoint(x: 1, y: 0)
        }
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor?.cgColor ?? tintColor.cgColor
        if cornerRadius > 0 {
            layer.masksToBounds = true
        }
        updateFrame()
    }
    
    // MARK: - On Click
    @objc private func clickAction(button: UIButton) {
        onClick()
    }
    
}
