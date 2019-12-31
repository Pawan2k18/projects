//
//  Line.swift
//  Travanada2
//
//  Created by Pawan Dey on 02/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class Line: UIView {

    var line = UIBezierPath()
    var line2 = UIBezierPath()
    
    
    func graph(){
        line.move(to: .init(x: 0, y: bounds.height / 2))
        line.addLine(to: .init(x: bounds.width, y: bounds.height / 2))
        
        UIColor.lightGray.setStroke()
        line.lineWidth = 0.3
        line.stroke()
        
        line2.move(to: .init(x: bounds.width / 2, y: 0))
        line2.addLine(to: .init(x: bounds.width / 2, y: bounds.height / 2))
        
        UIColor.lightGray.setStroke()
        line2.lineWidth = 0.3
        line2.stroke()
        
    }
    
    
    override func draw(_ rect: CGRect) {
        graph()
    }
    
}
