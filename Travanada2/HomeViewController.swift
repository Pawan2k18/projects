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
    func updateDetail(_ strAdult: String, _ strChild: String, _ strInfant: String, _ strClasstype: String)
}

class HomeViewController: UIViewController, CalendarCallBack {
    let dollarSign = "\u{24}" 
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
    @IBOutlet weak var searchBtn: UIButton!

    var finalSource = ""
    var finalDestination = ""
    var adultval = ""
    var childval = ""
    var infantval = ""
    var ticketClass = ""
    
    @IBAction func flightTap(_ sender: UIButton) {

        if ViewOutlet.tag == 0
        {
            ViewOutlet.tag = 1
            ViewOutlet.isHidden = true
            flightBtn.setImage(UIImage(named: "flight-d.png"), for: .normal)
        }
            
        else if ViewOutlet.tag == 1
        {
            ViewOutlet.tag = 0
            ViewOutlet.isHidden = false
            flightBtn.setImage(UIImage(named: "flight.png"), for: .normal)
            
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
       
        sourceBtn.layer.borderWidth = 1
        sourceBtn.layer.borderColor = UIColor.lightGray.cgColor
        sourceBtn.layer.cornerRadius = 10
        sourceBtn.layer.shadowRadius = 1
        sourceBtn.layer.shadowColor = UIColor.lightGray.cgColor
        
        destinationBtn.layer.borderWidth = 1
        destinationBtn.layer.borderColor = UIColor.lightGray.cgColor
        destinationBtn.layer.cornerRadius = 10
        destinationBtn.layer.shadowColor = UIColor.lightGray.cgColor
        
        settingData()
        
    }
    
    func settingData(){
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
        else if(segue.identifier == "resultsegue"){
            let displayVC = segue.destination as! ResultViewController
            displayVC.mySource = sourceBtn.currentTitle!
            displayVC.myDest = destinationBtn.currentTitle!
            displayVC.myAdult = adultval
            displayVC.myChild = childval
            displayVC.myInfant = infantval
            displayVC.myTickettype = ticketClass
            displayVC.myDate = dateLabel.text!
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
        print("date is- \(dateLabel.text!)")
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
        self.performSegue(withIdentifier: "resultsegue", sender: self)

        }
    }
    


extension HomeViewController: UpdateHomeViewControllerDelegate {
    
    func updateDest(_ strDestL: String) {
        destinationBtn.setTitle(strDestL, for: .normal)
    }
    
    func updateSource(_ strSource: String) {
        sourceBtn.setTitle(strSource, for: .normal)
    }
    
    func updateDetail(_ strAdult: String, _ strChild: String, _ strInfant: String, _ strClasstype: String) {
        adultval = strAdult
        childval = strChild
        infantval = strInfant
        ticketClass = strClasstype
        
        passengerLabel.text = (strAdult) + "+" + (strChild) + "+" + (strInfant) + " Traveller"
        detailbtn.setTitle(strClasstype, for: .normal)
    }
}

//extension UIButton{
//    func applyButtonDesgin(){
//        self.backgroundColor = UIColor.darkGray
//        self.layer.cornerRadius = self.frame.height / 2
//        self.setTitleColor(UIColor.white, for: .normal)
//        self.layer.shadowColor = UIColor.darkGray.cgColor
//        self.layer.shadowRadius = 6
//        self.layer.shadowOpacity = 0.5
//        self.layer.shadowOffset = CGSize(width: 0, height: 0)
//    }
//}
