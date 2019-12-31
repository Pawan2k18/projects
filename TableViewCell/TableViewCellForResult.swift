//
//  TableViewCellForResult.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import AlamofireImage

class TableViewCellForResult: UITableViewCell {

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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
