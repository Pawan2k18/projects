//
//  TableViewCell.swift
//  JOSNSwiftDemo
//
//  Created by Shinkangsan on 12/5/16.
//  Copyright © 2016 Sheldon. All rights reserved.
//

import UIKit
import Foundation

class TableViewCell: UITableViewCell {

    @IBOutlet weak var imgViewLogo: UIImageView!
    @IBOutlet weak var labelArrivalAirport: UILabel!
    @IBOutlet weak var labelDepartureAirport: UILabel!
    @IBOutlet weak var labelArrivalTime: UILabel!
    @IBOutlet weak var labelDepartureTime: UILabel!
    @IBOutlet weak var labelTotalTime: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelTotalFare: UILabel!
    @IBOutlet weak var oneview: UIView!
    
    var viewController : UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        oneview?.layer.cornerRadius = 5.0
        oneview?.layer.masksToBounds = true
        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }


    
}
