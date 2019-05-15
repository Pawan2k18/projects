//
//  DetailsViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 08/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var delegate: UpdateHomeViewControllerDelegate?
    
    @IBOutlet weak var adultStepper: GMStepper!
    @IBOutlet weak var childStepper: GMStepper!
    @IBOutlet weak var infantsStepper: GMStepper!
    @IBOutlet weak var classTicketSegment: UISegmentedControl!
    
    var adultStepperVal = ""
    var childStepperVal = ""
    var infantsStepperVal = ""

    var classTicketSegmentVal: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    
    // func for one ticket class
//    @IBAction func classTicketSegmentTapped(_ sender: Any) {
//
//        let getIndex = classTicketSegment.selectedSegmentIndex
//        print(getIndex)
//
//        switch (getIndex) {
//        case 0:
//            print("Economy")
//        case 1:
//            print("premium")
//        case 3:
//            print("Business")
//        case 4:
//            print("First")
//        default:
//            print("Economy")
//        }
//
//    }

    
    @IBAction func seletedTicketType(_ sender: UISegmentedControl) {
        classTicketSegmentVal = sender.titleForSegment(at: sender.selectedSegmentIndex)
    }
    
    @IBAction func cancelBtnDetailsTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtndetails(_ sender: Any) {
        self.delegate?.updateDetail(adultStepperVal ,classTicketSegmentVal)
        self.dismiss(animated: true, completion: nil)
       
    }

}
