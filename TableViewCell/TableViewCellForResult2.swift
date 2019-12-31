//
//  TableViewCellForResult2.swift
//  Travanada2
//
//  Created by Pawan Dey on 27/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCellForResult2: UITableViewCell {
    
    
    @IBOutlet weak var DepAirportName: UILabel!
    @IBOutlet weak var ArrAirportName: UILabel!
    @IBOutlet weak var DepAirportTime: UILabel!
    @IBOutlet weak var ArrAirportTime: UILabel!
    @IBOutlet weak var DepAirportDate: UILabel!
    @IBOutlet weak var ArrAirportDate: UILabel!
    @IBOutlet weak var DepAirportAddress: UILabel!
    @IBOutlet weak var ArrAirportAddress: UILabel!
    @IBOutlet weak var TotalTime: UILabel!
    @IBOutlet weak var FlightLogo: UIImageView!
    @IBOutlet weak var flightName: UILabel!
    @IBOutlet weak var flightCode: UILabel!
    
    
    @IBOutlet weak var DepAirportName2: UILabel!
    @IBOutlet weak var ArrAirportName2: UILabel!
    @IBOutlet weak var DepAirportTime2: UILabel!
    @IBOutlet weak var ArrAirportTime2: UILabel!
    @IBOutlet weak var DepAirportDate2: UILabel!
    @IBOutlet weak var ArrAirportDate2: UILabel!
    @IBOutlet weak var DepAirportAddress2: UILabel!
    @IBOutlet weak var ArrAirportAddress2: UILabel!
    @IBOutlet weak var TotalTime2: UILabel!
    @IBOutlet weak var FlightLogo2: UIImageView!
    @IBOutlet weak var flightName2: UILabel!
    @IBOutlet weak var flightCode2: UILabel!
    
    
    @IBOutlet weak var roundtripsegview: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

