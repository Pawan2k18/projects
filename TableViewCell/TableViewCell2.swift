//
//  TableViewCell2.swift
//  Travanada2
//
//  Created by Pawan Dey on 26/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    @IBOutlet weak var imgViewLogo1: UIImageView!
    @IBOutlet weak var labelArrivalAirport1: UILabel!
    @IBOutlet weak var labelDepartureAirport1: UILabel!
    @IBOutlet weak var labelArrivalTime1: UILabel!
    @IBOutlet weak var labelDepartureTime1: UILabel!
    @IBOutlet weak var labelTotalTime1: UILabel!
    @IBOutlet weak var stoppage1: UILabel!
    @IBOutlet weak var FlightCodeNubmer1: UILabel!
    @IBOutlet weak var labelTotalFare1: UILabel!
    
    @IBOutlet weak var imgViewLogo2: UIImageView!
    @IBOutlet weak var labelArrivalAirport2: UILabel!
    @IBOutlet weak var labelDepartureAirport2: UILabel!
    @IBOutlet weak var labelArrivalTime2: UILabel!
    @IBOutlet weak var labelDepartureTime2: UILabel!
    @IBOutlet weak var labelTotalTime2: UILabel!
    @IBOutlet weak var stoppage2: UILabel!
    @IBOutlet weak var FlightCodeNubmer2: UILabel!
    
    @IBOutlet weak var inboundLbl: UILabel!
    @IBOutlet weak var outboundLbl: UILabel!
    
    @IBOutlet weak var roundView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
//        inboundLbl?.layer.cornerRadius = 5.0
//        outboundLbl?.layer.cornerRadius = 5.0
//        fareLbl?.layer.cornerRadius = 5.0
//        outboundLbl?.layer.masksToBounds = true
//        fareLbl?.layer.masksToBounds = true
//        inboundLbl?.layer.masksToBounds = true
//        roundView?.layer.cornerRadius = 5.0
//        roundView?.layer.masksToBounds = true
        
//        myView.layer.cornerRadius = 20.0
//        myView.layer.shadowColor = UIColor.gray.cgColor
//        myView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
//        myView.layer.shadowRadius = 12.0
//        myView.layer.shadowOpacity = 0.7
        
        
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
