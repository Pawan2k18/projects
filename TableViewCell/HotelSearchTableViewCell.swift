//
//  HotelSearchTableViewCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 11/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class HotelSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var HotelImg: UIImageView!
    @IBOutlet weak var HotelName: UILabel!
    @IBOutlet weak var HotelAddress: UILabel!
    @IBOutlet weak var HotelRating: UILabel!
    @IBOutlet weak var HotelDistance: UILabel!
    @IBOutlet weak var HotelFare: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func PayNowBtn(_ sender: Any) {
        print("clicked")
    }
}
