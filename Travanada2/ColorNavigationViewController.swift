////
////  ColorNavigationViewController.swift
////  asdfsadfsdf
////
////  Created by Pisit W on 5/11/2561 BE.
////  Copyright © 2561 23Perspective. All rights reserved.
////
//
//import UIKit
//import Foundation
//
//class ColorNavigationViewController: UINavigationController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        configNavigationBar()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//        changeGradientImage()
//    }
//    
//    let orangeGradient = [UIColor(rgb: 0x3A26B4), UIColor(rgb: 0x6E19A3)]
//    let orangeGradientLocation = [0.0, 0.5]
//    
//    lazy var colorView = { () -> UIView in
//        let view = UIView()
//        view.isUserInteractionEnabled = false
//        navigationBar.addSubview(view)
//        navigationBar.sendSubview(toBack: view)
//        return view
//    }()
//    
//    func changeGradientImage() {
//        // 1 status bar
//        colorView.frame = CGRect(x: 0, y: -UIApplication.shared.statusBarFrame.height, width: navigationBar.frame.width, height: UIApplication.shared.statusBarFrame.height)
//        
//        // 2
//        colorView.backgroundColor = UIColor(patternImage: gradientImage(withColours: orangeGradient, location: orangeGradientLocation, view: navigationBar).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: navigationBar.frame.size.width/2, bottom: 10, right: navigationBar.frame.size.width/2), resizingMode: .stretch))
//        
//        // 3 small title background
//        navigationBar.setBackgroundImage(gradientImage(withColours: orangeGradient, location: orangeGradientLocation, view: navigationBar), for: .default)
//
//        // 4 large title background
//        navigationBar.layer.backgroundColor = UIColor(patternImage: gradientImage(withColours: orangeGradient, location: orangeGradientLocation, view: navigationBar).resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: navigationBar.frame.size.width/2, bottom: 10, right: navigationBar.frame.size.width/2), resizingMode: .stretch)).cgColor
//    }
//    
//    func configNavigationBar() {
//        navigationBar.barStyle = .default
//        navigationBar.shadowImage = UIImage()
//        navigationBar.isTranslucent = false
//        if #available(iOS 11.0, *) {
//            navigationBar.prefersLargeTitles = true
//        } else {
//            // Fallback on earlier versions
//        }
//        if #available(iOS 11.0, *) {
//            navigationItem.largeTitleDisplayMode = .always
//        } else {
//            // Fallback on earlier versions
//        }
//        
//        navigationBar.tintColor = UIColor.white
//        if #available(iOS 11.0, *) {
//            navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        } else {
//            // Fallback on earlier versions
//        }
//        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//    }
//    
//    func gradientImage(withColours colours: [UIColor], location: [Double], view: UIView) -> UIImage {
//        let gradient = CAGradientLayer()
//        gradient.frame = view.bounds
//        gradient.colors = colours.map { $0.cgColor }
//        gradient.startPoint = (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5)).0
//        gradient.endPoint = (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5)).1
//        gradient.locations = location as [NSNumber]
//        gradient.cornerRadius = view.layer.cornerRadius
//        return UIImage.image(from: gradient) ?? UIImage()
//    }
//
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
//}
//
//extension UIColor {
//    convenience init(red: Int, green: Int, blue: Int) {
//        assert(red >= 0 && red <= 255, "Invalid red component")
//        assert(green >= 0 && green <= 255, "Invalid green component")
//        assert(blue >= 0 && blue <= 255, "Invalid blue component")
//        
//        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
//    }
//    
//    convenience init(rgb: Int) {
//        self.init(
//            red: (rgb >> 16) & 0xFF,
//            green: (rgb >> 8) & 0xFF,
//            blue: rgb & 0xFF
//        )
//    }
//}
//
//extension UIImage {
//    class func image(from layer: CALayer) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(layer.bounds.size,
//                                               layer.isOpaque, UIScreen.main.scale)
//        
//        defer { UIGraphicsEndImageContext() }
//        
//        // Don't proceed unless we have context
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return nil
//        }
//        
//        layer.render(in: context)
//        return UIGraphicsGetImageFromCurrentImageContext()
//    }
//}
