//
//  PassengerDetailsCell.swift
//  Travanada2
//
//  Created by Pawan Dey on 09/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class PassengerDetailsCell: UITableViewCell {

    @IBOutlet weak var title: DropDown!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var gender: DropDown!
    @IBOutlet weak var dobday: SDCTextField!
    @IBOutlet weak var dobmonth: SDCTextField!
    @IBOutlet weak var dobyear: SDCTextField!
    @IBOutlet weak var passengerLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
 
        self.dobday.maxLength = 2
        self.dobmonth.maxLength = 2
        self.dobyear.maxLength = 4
    
        
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

       
    }
    
}
