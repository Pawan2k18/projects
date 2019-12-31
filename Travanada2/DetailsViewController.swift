//
//  DetailsViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 08/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var adultStepper: GMStepper!
    @IBOutlet weak var childStepper: GMStepper!
    @IBOutlet weak var infantsStepper: GMStepper!
    @IBOutlet weak var classTicketType2: CustomSegmentedControl!
    
    var adultStepperVal = ""
    var childStepperVal = ""
    var infantsStepperVal = ""
    var ticketTypeVal = ""
    
    // getting all data from previus view (CustomTestingClass) and initiliazing here:
    var originVal = ""
    var destinationVal = ""
    var journeyDate = ""
    var returnDate = ""
    var journeyDay = ""
    var returnDay = ""
    var tripType = ""
    var counter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CustomTestingClass.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle-4")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        adultStepperVal = "1"
        childStepperVal = "0"
        infantsStepperVal = "0"
        ticketTypeVal = "ECONOMY"
        
        adultStepper.addTarget(self, action: #selector(DetailsViewController.adultStepperValueChanged), for: .valueChanged)
        
        childStepper.addTarget(self, action: #selector(DetailsViewController.childStepperValueChanged), for: .valueChanged)
        
        infantsStepper.addTarget(self, action: #selector(DetailsViewController.infantsStepperValueChanged), for: .valueChanged)
        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        
        print("pressed back button not via segue")
        // Perform your custom actions
        
        StructOperation.glovalVariable.userName = "fromBack"
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
    

    @objc func adultStepperValueChanged(adultStepper: GMStepper) {
        print(adultStepper.value, terminator: "")
        adultStepperVal = String (adultStepper.value)
    }
    
    @objc func childStepperValueChanged(childStepper: GMStepper) {
        print(childStepper.value, terminator: "")
        childStepperVal = String (childStepper.value)
    }
    @objc func infantsStepperValueChanged(infantsStepper: GMStepper) {
        print(infantsStepper.value, terminator: "")
        infantsStepperVal = String (infantsStepper.value)
    }
    
    
    
    @IBAction func classTicketType2(_ sender: CustomSegmentedControl) {
        
        switch sender.selectedSegmentedIndex {
            
        case 0:
            self.ticketTypeVal = "economy"
            ticketTypeVal = ticketTypeVal.uppercased()
            print(ticketTypeVal)
        case 1:
            self.ticketTypeVal = "premium_economy"
            ticketTypeVal = ticketTypeVal.uppercased()
            print(ticketTypeVal)
        case 2:
            self.ticketTypeVal = "business"
            ticketTypeVal = ticketTypeVal.uppercased()
            print(ticketTypeVal)
        case 3:
            self.ticketTypeVal = "first"
            ticketTypeVal = ticketTypeVal.uppercased()
            print(ticketTypeVal)
        default:
            self.ticketTypeVal = "economy"
            ticketTypeVal = ticketTypeVal.uppercased()
            print(ticketTypeVal)
        }
    }
    
    
    @IBAction func cancelBtnDetailsTap(_ sender: Any) {
       _ = navigationController?.popViewController(animated: true) //navigationController?.popViewController(animated: true)
       // self.dismiss(animated: true, completion: nil)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "detToHome" {
            let navController = segue.destination as! UINavigationController
            let displayVC = navController.topViewController as! HomeViewController
            displayVC.data = "tappedOk"
            displayVC.counter = true
        }
    }
        
    
    
    @IBAction func doneBtndetails(_ sender: Any) {
        
        performSegue(withIdentifier: "detToHome", sender: self)
        StructOperation.glovalVariable.userName = "fromDone"
        //self.dismiss(animated: true, completion: nil)
       
        
     let defaults = UserDefaults.standard
     let flightData = ["origin" : originVal,
                       "destination" : destinationVal,
                       "journeyDate" : journeyDate,
                       "returnDate" : returnDate,
                       "journeyDay" : journeyDay,
                       "returnDay" : returnDay,
                       "tripType" : tripType,
                       "totalAdult" : adultStepperVal,
                       "totalChild" : childStepperVal,
                       "totalInfant" : infantsStepperVal,
                       "ticketType" : ticketTypeVal ]
    
        defaults.set(flightData, forKey: "SavedFlightData")

    }
}
