//
//  HomeViewController.swift
//  FirebaseApp
//
//  Created by Robert Canton on 2018-02-02.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DashboardViewController:UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var uidLbl: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserDetails()
    }
    
    @IBAction func gotoHome(_ sender: Any) {
        
    }
    
    func getUserDetails(){
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            let email = user.email!
            
            print("uid - \(uid)")
            print("email - \(email)")
            
            nameLbl.text = uid
            emailLbl.text = email
        }
    }
    
    
    @IBAction func handleLogout(_ sender:Any) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false, completion: nil)

    }
    
}
