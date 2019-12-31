//
//  BookingView.swift
//  Travanada2
//
//  Created by Pawan Dey on 13/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import RealmSwift

class BookingView: UIViewController {

    @IBOutlet weak var bookRefLbl: UILabel!
    var bookingRef = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bookRefLbl?.text = StructOperation.bookingRef.bookingid
        
    }

    @IBAction func backtoHome(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(secondVC, animated: true)
    }
}
