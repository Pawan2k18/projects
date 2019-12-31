//
//  HotelCell1.swift
//  Travanada2
//
//  Created by Pawan Dey on 07/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class HotelCell1: UITableViewCell {

    
    @IBOutlet var HotelName: UILabel!
    @IBOutlet var HotelAddress: UILabel!
    @IBOutlet var HotelRating: UILabel!
    @IBOutlet var HotelDistance: UILabel!
    @IBOutlet var HotelCity: UILabel!
    
    @IBOutlet weak var HotelImage: UIImageView!
    
    @IBOutlet weak var HotelDescription: UITextView!
    
    @IBOutlet var HotelAmenities1: UIImageView!
    @IBOutlet var HotelAmenities2: UIImageView!
    @IBOutlet var HotelAmenities3: UIImageView!
    @IBOutlet var HotelAmenities4: UIImageView!
    @IBOutlet var HotelAmenities5: UIImageView!
    @IBOutlet var HotelAmenities6: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
