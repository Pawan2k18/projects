//
//  HotelTableViewCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 03/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class HotelTableViewCell: UITableViewCell {

    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelAddress: UILabel!
    @IBOutlet weak var checkin: UILabel!
    @IBOutlet weak var checkout: UILabel!
    @IBOutlet weak var totalFare: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
