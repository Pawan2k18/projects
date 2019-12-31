//
//  UnderlineLabel.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import Foundation
import UIKit

class UnderlineLabel: UILabel {
    
    override var text: String? {
        didSet {
            guard let text = text else { return }
            let textRange = NSMakeRange(0, text.count)
            let attributedText = NSMutableAttributedString(string: text)
            attributedText.addAttribute(NSAttributedString.Key.underlineStyle , value: NSUnderlineStyle.styleSingle.rawValue, range: textRange)
            // Add other attributes if needed
            self.attributedText = attributedText
        }
    }
}
