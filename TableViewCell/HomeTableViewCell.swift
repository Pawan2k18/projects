//
//  HomeTableViewCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 11/07/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class HomeTableViewCell: UIView {

    @IBOutlet var containerView: UIView!

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var HotelLoc: UILabel!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var fromDay: UILabel!
    
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var toDate: UILabel!
    @IBOutlet weak var toDay: UILabel!
    
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var guest: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    
    
    private func commitInit(){
        Bundle.main.loadNibNamed("HomeTableViewCell", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 1
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        containerView.layer.masksToBounds = true
        
    
    }
    
//    @IBAction func closeButton(_ sender: Any) {
//        let defaults = UserDefaults.standard
//        defaults.removeObject(forKey: "SavedFlightData")
//        StructOperation.glovalVariable2.newViewCloseBtn = "removeNewView"
//        containerView.removeFromSuperview()
//        
//        
//    }
 
    
}
