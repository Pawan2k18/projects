//
//  CardView.swift
//  Travanada2
//
//  Created by Pawan Dey on 30/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var oneReturnWay: UILabel!
    @IBOutlet weak var sourceLbl: UILabel!    
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var depDate: UILabel!
    @IBOutlet weak var depDay: UILabel!
    @IBOutlet weak var retDate: UILabel!
    @IBOutlet weak var retDay: UILabel!
    @IBOutlet weak var classType: UILabel!
    @IBOutlet weak var tripImg: UIImageView!
    @IBOutlet weak var firView: UIView!
    @IBOutlet weak var secView: UIView!
    @IBOutlet weak var passengerLbl: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    
    
    private func commitInit(){
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = self.bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]

    
        oneReturnWay.isUserInteractionEnabled = true
        sourceLbl.isUserInteractionEnabled = true
        destinationLbl.isUserInteractionEnabled = true
        depDate.isUserInteractionEnabled = true
        depDay.isUserInteractionEnabled = true
        retDate.isUserInteractionEnabled = true
        retDay.isUserInteractionEnabled = true
        classType.isUserInteractionEnabled = true
        passengerLbl.isUserInteractionEnabled = true
        

        containerView.layer.cornerRadius = 10.0
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = .zero
        containerView.layer.shadowRadius = 12.0
        containerView.layer.shadowOpacity = 1
        containerView.layer.borderWidth = 0.3
        containerView.layer.borderColor = UIColor.darkGray.cgColor
        containerView.layer.masksToBounds = true
        
        oneReturnWay.layer.borderWidth = 0.3
        oneReturnWay.layer.cornerRadius = 10.0
        oneReturnWay.layer.borderColor = UIColor.darkGray.cgColor
        oneReturnWay.layer.masksToBounds = true
        
        passengerLbl.layer.borderWidth = 0.3
        passengerLbl.layer.cornerRadius = 10.0
        passengerLbl.layer.borderColor = UIColor.darkGray.cgColor
        passengerLbl.layer.masksToBounds = true
        
        
    }
    
    
    
//    @IBAction func closeButton(_ sender: Any) {
//            let defaults = UserDefaults.standard
//                   defaults.removeObject(forKey: "SavedFlightData")
//        StructOperation.glovalVariable2.newViewCloseBtn = "removeNewView"
//        containerView.removeFromSuperview()
//
//
//    }

}



