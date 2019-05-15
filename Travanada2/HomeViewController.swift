//
//  HomeViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 06/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

protocol UpdateHomeViewControllerDelegate: class {
    func updateSource(_ strSource: String)
    func updateDest(_ strDestL: String)
    func updateDetail(_ strDetail: String, _ intPassenger: String)
}

class HomeViewController: UIViewController, CalendarCallBack {

    var selectedDate = Date()
    let classtype = ["One Way", "Round Trip"]
    
    @IBOutlet weak var classSegment: UISegmentedControl!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ViewOutlet: UIView!
    
    @IBOutlet weak var passengerLabel: UILabel!
    @IBOutlet weak var sourceBtn: UIButton!
    @IBOutlet weak var destinationBtn: UIButton!
    @IBOutlet weak var detailbtn: UIButton!
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var hotelBtn: UIButton!
    
    var finalSource = ""
    var finalDestination = ""
    var adultval = ""
    
    @IBAction func flightTap(_ sender: UIButton) {

        if ViewOutlet.tag == 0
        {
            ViewOutlet.tag = 1
            ViewOutlet.isHidden = true
            flightBtn.setImage(UIImage(named: "flight.png"), for: .normal)
        }
            
        else if ViewOutlet.tag == 1
        {
            ViewOutlet.tag = 0
            ViewOutlet.isHidden = false
            flightBtn.setImage(UIImage(named: "flight-d.png"), for: .normal)
        }
    }
    
    
    
    @IBAction func hotelTap(_ sender: Any) {
        
        if hotelBtn.tag == 0
        {
            hotelBtn.tag = 1
            hotelBtn.setImage(UIImage(named: "hotel.png"), for: .normal)
        }
        else if hotelBtn.tag == 1
        {
             hotelBtn.tag = 0
            hotelBtn.setImage(UIImage(named: "hotel-d.png"), for: .normal)
        }
        
        
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sourceBtn.setTitle(finalSource, for: .normal)
        destinationBtn.setTitle(finalDestination, for: .normal)
        detailbtn.setTitle(adultval, for: .normal)

    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "ss" {
            let vc = segue.destination as! SourceViewController
            vc.delegate = self
        }
        else if segue.identifier  == "ds" {
            let vc = segue.destination as! DestinationViewController
            vc.delegate = self
        }
        else if segue.identifier  == "ps"{
            let vc = segue.destination as! DetailsViewController
            vc.delegate = self
        }
    }
    
    
    // func for date seletion
    @IBAction func searchTap(_ sender: UIButton) {
    print("clicked done")
     let CalendarViewController = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        CalendarViewController.modalPresentationStyle = .overCurrentContext
        CalendarViewController.delegate = self
        CalendarViewController.selectedDate = selectedDate
        self.present(CalendarViewController, animated: false, completion: nil)
    }
    
    func didSelectDate(date: Date) {
        selectedDate = date
        dateLabel.isHidden = false
        dateLabel.text = date.getTitleDateFC()
    }
    
    
    
    
    // func for one way and round trip
    @IBAction func classSegmentTapped(_ sender: Any) {
        
        let getIndex = classSegment.selectedSegmentIndex
        print(getIndex)
        
        switch (getIndex) {
        case 0:
            print("One Way")
        case 1:
            print("Round Trip")
        default:
            print("One Way")
        }
    }
    
    
    
    @IBAction func searchFlightBtn(_ sender: Any) {
        print("Searching Flights...")
        let source = sourceBtn.currentTitle!
        print(source)
        let dest = destinationBtn.currentTitle!
        print(dest)
        let detail = detailbtn.currentTitle!
        print(detail)
        let passenger = passengerLabel.text!
        print(passenger)
        
    }
    
    
    
    
}


extension HomeViewController: UpdateHomeViewControllerDelegate {
    
    func updateDest(_ strDestL: String) {
        destinationBtn.setTitle(strDestL, for: .normal)
    }
    
    func updateSource(_ strSource: String) {
        sourceBtn.setTitle(strSource, for: .normal)
    }
    
    func updateDetail(_ strDetail: String, _ intPassenger: String) {
        passengerLabel.text = (strDetail) + " Traveller"
        detailbtn.setTitle(intPassenger, for: .normal)
    }
}
