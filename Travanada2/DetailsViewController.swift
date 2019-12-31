//
//  DetailsViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 08/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

protocol DataPass3{
    func dataPassing3(adult: String, child: String, infant: String, classType: String)
}


class DetailsViewController: UIViewController {
    
       var delegate3:DataPass3!
    
    
    @IBOutlet weak var adultStepper: GMStepper!
    @IBOutlet weak var childStepper: GMStepper!
    @IBOutlet weak var infantsStepper: GMStepper!
    @IBOutlet weak var classTicketType2: CustomSegmentedControl!
    
    var adultStepperVal = ""
    var childStepperVal = ""
    var infantsStepperVal = ""
    var ticketTypeVal = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        adultStepperVal = "1"
        childStepperVal = "0"
        infantsStepperVal = "0"
        ticketTypeVal = "ECONOMY"
        
        adultStepper.addTarget(self, action: #selector(DetailsViewController.adultStepperValueChanged), for: .valueChanged)
        
        childStepper.addTarget(self, action: #selector(DetailsViewController.childStepperValueChanged), for: .valueChanged)
        
        infantsStepper.addTarget(self, action: #selector(DetailsViewController.infantsStepperValueChanged), for: .valueChanged)
        
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
    
    
    
    @IBAction func doneBtndetails(_ sender: Any) {
    
        delegate3.dataPassing3(adult: adultStepperVal, child: childStepperVal, infant: infantsStepperVal, classType: ticketTypeVal)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)

    }
}
