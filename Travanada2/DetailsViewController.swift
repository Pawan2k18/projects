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
    @IBOutlet weak var seatInfantsStepper: GMStepper!
    @IBOutlet weak var lapInfantsStepper: GMStepper!
    @IBOutlet weak var classTicketSegment: UISegmentedControl!
    
    var adultStepperVal = ""
    var childStepperVal = ""
    var seatInfantsStepperVal = ""
    var lapInfantsStepperVal = ""
    var classTicketSegmentVal = ""
    
    var aval = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        adultStepper.addTarget(self, action: #selector(DetailsViewController.adultStepperValueChanged), for: .valueChanged)
        
        childStepper.addTarget(self, action: #selector(DetailsViewController.childStepperValueChanged), for: .valueChanged)
        
        seatInfantsStepper.addTarget(self, action: #selector(DetailsViewController.seatInfantsStepperValueChanged), for: .valueChanged)
        
        lapInfantsStepper.addTarget(self, action: #selector(DetailsViewController.lapInfantsStepperValueChanged), for: .valueChanged)
        
    }
    
    @objc func adultStepperValueChanged(adultStepper: GMStepper) {
        print(adultStepper.value, terminator: "")
        adultStepperVal = String (adultStepper.value)
    }
    
    @objc func childStepperValueChanged(childStepper: GMStepper) {
        print(childStepper.value, terminator: "")
        childStepperVal = String (childStepper.value)
    }
    @objc func seatInfantsStepperValueChanged(seatInfantsStepper: GMStepper) {
        print(seatInfantsStepper.value, terminator: "")
        seatInfantsStepperVal = String (seatInfantsStepper.value)
    }
    
    @objc func lapInfantsStepperValueChanged(lapInfantsStepper: GMStepper) {
        print(lapInfantsStepper.value, terminator: "")
        lapInfantsStepperVal = String (lapInfantsStepper.value)
    }
    
    
    
    // func for one ticket class
    @IBAction func classTicketSegmentTapped(_ sender: Any) {
        
        let getIndex = classTicketSegment.selectedSegmentIndex
        print(getIndex)
        
        switch (getIndex) {
        case 0:
            print("Economy")
        case 1:
            print("premium")
        case 3:
            print("Business")
        case 4:
            print("First")
        default:
            print("Economy")
        }
        
    }

    
    
    @IBAction func cancelBtnDetailsTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
 
    
    @IBAction func doneBtndetails(_ sender: Any) {
        self.aval = adultStepperVal
        performSegue(withIdentifier: "returndetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc3 = segue.destination as! HomeViewController
        vc3.adultval = self.aval
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
