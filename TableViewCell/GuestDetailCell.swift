//
//  GuestDetailCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 11/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class GuestDetailCell: UITableViewCell {
    
    
    @IBOutlet weak var guestLbl: UILabel!
    @IBOutlet weak var title: DropDown!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var gender: DropDown!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.title.text = "Mr."
        // The list of array to display. Can be changed dynamically
        title.optionArray = ["Mr.", "Mrs.", "Miss"]
        
        // The the Closure returns Selected Index and String
        title.didSelect{(selectedText , index ,id) in
            self.title.text = "\(selectedText)"
        }
        
        
        
        self.gender.text = "Male"
        // The list of array to display. Can be changed dynamically
        gender.optionArray = ["Male", "Female"]
        
        // The the Closure returns Selected Index and String
        gender.didSelect{(selectedText , index ,id) in
            self.gender.text = "\(selectedText)"
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
