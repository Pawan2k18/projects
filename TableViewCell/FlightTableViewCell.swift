//
//  FlightTableViewCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 03/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class FlightTableViewCell: UITableViewCell {

    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var deptime: UILabel!
    @IBOutlet weak var arrtime: UILabel!
    @IBOutlet weak var totalfare: UILabel!
    @IBOutlet weak var flightType: UILabel!
    
    @IBOutlet weak var flightimage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
