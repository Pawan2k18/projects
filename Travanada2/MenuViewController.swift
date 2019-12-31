//
//  ViewController.swift
//  FirebaseDemo
//
//  Created by Robert Canton on 2017-09-13.
//  Copyright © 2017 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class MenuViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func tapHome(_ sender: Any) {
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.present(secondVC, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add the background gradient
        //view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
//        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"loginform")!)
//        self.view.contentMode = .scaleAspectFill
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let user = Auth.auth().currentUser {
            
            let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "PaymentView") as! PaymentView
            self.navigationController?.pushViewController(secondVC, animated: true)
            
            
            
            //self.performSegue(withIdentifier: "toHomeScreen", sender: self)
            
//            let mvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalViewController") as? ModalViewController {
//                self.present(mvc, animated: true, completion: nil)
            
//            if (StructOperation.FlightOrHotel.comingfrom == "Hotel"){
//                let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "GuestNames") as! GuestNames
//                self.present(secondVC, animated: true, completion: nil)
//            }
//            if (StructOperation.FlightOrHotel.comingfrom == "Flight"){
//                let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
//                let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HView2") as! HView2
//                self.present(secondVC, animated: true, completion: nil)
//            }
            
            
        }
    }
    
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
}
