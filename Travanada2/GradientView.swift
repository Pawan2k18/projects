//
//  GradientView.swift
//  Travanada2
//
//  Created by Pawan Dey on 17/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    var FirstColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    var SecondColor: UIColor = UIColor.clear{
        didSet{
            updateView()
        }
    }
    override class var layerClass: AnyClass{
        get {
            return CAGradientLayer.self
        }
    }
    func updateView(){
        let layer = self.layer as! CAGradientLayer
        layer.colors = [ FirstColor.cgColor, SecondColor.cgColor]
    }
    
    
}
