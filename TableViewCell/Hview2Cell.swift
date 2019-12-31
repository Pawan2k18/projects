//
//  Hview2Cell.swift
//  Travanada2
//
//  Created by Pawan Dey on 06/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class Hview2Cell: UITableViewCell {

    
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var roomcat: UILabel!
    
    @IBOutlet weak var fare: UILabel!
    @IBOutlet weak var adults: UILabel!
    @IBOutlet weak var bedtype: UILabel!
    @IBOutlet weak var roombed: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
