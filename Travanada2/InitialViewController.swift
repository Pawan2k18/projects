//
//  InitialViewController.swift
//  CloudFunctions
//
//  Created by Robert Canton on 2017-09-13.
//  Copyright © 2017 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class InitialViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(StructOperation.FlightOrHotel.comingfrom)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //- Todo: Check if user is authenticated. If so, segue to the HomeViewController, otherwise, segue to the MenuViewController
        
        if let user = Auth.auth().currentUser {
            let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "PaymentView") as! PaymentView
            self.present(secondVC, animated: true)
        }
        else{
             self.performSegue(withIdentifier: "toMenuScreen", sender: self)
        }

        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
}

