//
//  UIView+Animation.swift
//  Travanada2
//
//  Created by Pawan Dey on 22/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

extension UIView {
    
    func move(to destination: CGPoint, duration: TimeInterval,
              options: UIView.AnimationOptions) {
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: {
            self.center = destination
        }, completion: nil)
    }
    
}
