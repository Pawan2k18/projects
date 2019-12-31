//
//  RoomGuestForm.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/07/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

protocol DataPass5{
    func dataPassing5(rooms:String, adults:String, childs:String)
}


class RoomGuestForm: UIViewController {

    @IBOutlet weak var RoomsSelection: GMStepper!
    @IBOutlet weak var AdultsSelection: GMStepper!
    @IBOutlet weak var ChildsSelection: GMStepper!
    
     var delegate5:DataPass5!
    
    var roomsStepperVal = ""
    var adultsStepperVal = ""
    var childsStepperVal = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        roomsStepperVal = "1"
        adultsStepperVal = "1"
        childsStepperVal = "0"
        
        RoomsSelection.addTarget(self, action: #selector(RoomGuestForm.roomsStepperValueChanged), for: .valueChanged)
        
        AdultsSelection.addTarget(self, action: #selector(RoomGuestForm.adultsStepperValueChanged), for: .valueChanged)
        
        ChildsSelection.addTarget(self, action: #selector(RoomGuestForm.childsStepperValueChanged), for: .valueChanged)
        
    }
    
    
    @objc func roomsStepperValueChanged(RoomsSelection: GMStepper) {
        print(RoomsSelection.value, terminator: "")
        roomsStepperVal = String (RoomsSelection.value)
    }
    
    @objc func adultsStepperValueChanged(AdultsSelection: GMStepper) {
        print(AdultsSelection.value, terminator: "")
        adultsStepperVal = String (AdultsSelection.value)
    }
    @objc func childsStepperValueChanged(ChildsSelection: GMStepper) {
        print(ChildsSelection.value, terminator: "")
        childsStepperVal = String (ChildsSelection.value)
    }
    
    
    
    
    @IBAction func closeBtn(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true) //navigationController?.popViewController(animated: true)
        // self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func doneBtn(_ sender: Any) {
        delegate5.dataPassing5(rooms: roomsStepperVal, adults: adultsStepperVal, childs: childsStepperVal)
        
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
