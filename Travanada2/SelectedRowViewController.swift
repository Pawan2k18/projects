//
//  SelectedRowViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 20/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import RealmSwift

class SelectedRowViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!
    var flights :  Results<FlightData>!
    
    let euroSign = "\u{20AC}"
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currencySign: UILabel!
    @IBOutlet weak var totalTravellers: UILabel!
    @IBOutlet weak var totalFare: UILabel!
    @IBOutlet weak var addToCartBtn: UIButton!
    var isOneOrRound = ""
    
    let section = ["Outbound", "Inbound"]

    var titleStringViaSegue = [DictSegments()]
    var titleStringViaSegue2 = [DictServices()]
    var titleStringViaSegue3 = [DictSegments()]
    
    
    var totalFareVal:Int = 0
    var imageURL = ""
    var uniqueId = ""
    
    var finaldeptime = ""
    var finalarrtime = ""
    var finalarrdate = ""
    var finaldepdate = ""
    var aString = ""
    var newString3 = ""
    
    var flightNameCode = ""
    
    var DepAirportName      = ""
    var ArrAirportName      = ""
    var DepAirportTime      = ""
    var ArrAirportTime      = ""
    var DepAirportDate      = ""
    var ArrAirportDate      = ""
    var DepAirportAddress   = ""
    var ArrAirportAddress   = ""
    var TotalTime           = ""
    var FlightLogo          = ""
    var flightName          = ""
    var flightCode          = ""
    
    
        override func viewDidLoad() {
        super.viewDidLoad()
            
            var alldata = self.titleStringViaSegue2
            
            print(alldata)
            dump(alldata)
            
            
        self.addToCartBtn.layer.cornerRadius = 10
            
        self.ref = Database.database().reference()
        self.saveFIRData()
            
        print(Realm.Configuration.defaultConfiguration.fileURL!)
            
        totalFare.text = "\(self.euroSign) \(totalFareVal)"
        
    }
    
    
    
    func customAlert(){
    // Create the alert controller
        let alertController = UIAlertController(title: "Travanada", message: "Added To Cart", preferredStyle: .alert)
    
    // Create the actions
        let addmore = UIAlertAction(title: "Add More", style: UIAlertActionStyle.default) {
            
        UIAlertAction in
        NSLog("OK Pressed")
            
            let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(listVc, animated: true)
            
    }
        let goToCart = UIAlertAction(title: "Go to Cart", style: UIAlertActionStyle.cancel) {
            
        UIAlertAction in
        NSLog("Cancel Pressed")
            
            let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HView2") as! HView2
        
            self.navigationController?.pushViewController(secondVC, animated: true)
            
    }
    
    // Add the actions
    alertController.addAction(addmore)
    alertController.addAction(goToCart)
    
    // Present the controller
        self.present(alertController, animated: true, completion: nil)
    
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (isOneOrRound == "onewayselected"){
            return "Oneway"
        }else
        {
            return self.section[section]
        }
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        if (isOneOrRound == "onewayselected"){
            return 1
        }else
        {
            return self.section.count

        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isOneOrRound == "onewayselected"){
            return titleStringViaSegue.count
        }
        else
        {
            let dayModel = titleStringViaSegue2[section]
            return dayModel.arrsegments.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("isOneOrRound--\(isOneOrRound)")

        if (isOneOrRound == "onewayselected"){

        let cell =
            tableView.dequeueReusableCell(withIdentifier: "cell2") as! TableViewCellForResult
        
        self.DepAirportName    = titleStringViaSegue[indexPath.row].flightSegment.departure.iataCode
        self.ArrAirportName    = titleStringViaSegue[indexPath.row].flightSegment.arrival.iataCode
        self.DepAirportTime    = titleStringViaSegue[indexPath.row].flightSegment.departure.at
        self.ArrAirportTime    = titleStringViaSegue[indexPath.row].flightSegment.arrival.at
        self.DepAirportDate    = titleStringViaSegue[indexPath.row].flightSegment.departure.at
        self.ArrAirportDate    = titleStringViaSegue[indexPath.row].flightSegment.arrival.at
        self.DepAirportAddress = titleStringViaSegue[indexPath.row].flightSegment.departure.iataCode
        self.ArrAirportAddress = titleStringViaSegue[indexPath.row].flightSegment.arrival.iataCode
        //self.TotalTime         = newString3
        //self.FlightLogo        = imageURL
        self.flightName        = titleStringViaSegue[indexPath.row].flightSegment.number
        self.flightCode        = titleStringViaSegue[indexPath.row].flightSegment.carrierCode
        self.isOneOrRound      = "onewayselected"

        cell.DepAirportName.text? = titleStringViaSegue[indexPath.row].flightSegment.departure.iataCode
        cell.ArrAirportName.text? = titleStringViaSegue[indexPath.row].flightSegment.arrival.iataCode
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        let dateFormatterPrint2 = DateFormatter()
        dateFormatterPrint2.dateFormat = "MMM dd yyyy"
    
        // converting departuretime to Hours and mins
        //var finaldeptime = ""
        let deptime = titleStringViaSegue[indexPath.row].flightSegment.departure.at
        
        let deptime2 = deptime.index(deptime.startIndex, offsetBy: 18)
        let deptime3 = String(deptime[...deptime2])
        
        if let date = dateFormatterGet.date(from: deptime3) {
            finaldeptime = (dateFormatterPrint.string(from: date))
            print(finaldeptime)
        } else {
            print("There was an error decoding the string")
        }
        cell.DepAirportTime.text? = finaldeptime
        
        // converting arrivaltime to Hours and mins
        //var finalarrtime = ""
        let arrtime = titleStringViaSegue[indexPath.row].flightSegment.arrival.at
        
        let arrtime2 = arrtime.index(arrtime.startIndex, offsetBy: 18)
        let arrtime3 = String(arrtime[...arrtime2])
        
        if let date = dateFormatterGet.date(from: arrtime3) {
            finalarrtime = (dateFormatterPrint.string(from: date))
            print(finalarrtime)
        } else {
            print("There was an error decoding the string")
        }
        cell.ArrAirportTime.text? = finalarrtime

        // converting departuredate to month day year
        //var finaldepdate = ""
        
        let depdate = titleStringViaSegue[indexPath.row].flightSegment.departure.at
        let depdate2 = depdate.index(depdate.startIndex, offsetBy: 18)
        let depdate3 = String(depdate[...depdate2])
        
        if let date = dateFormatterGet.date(from: depdate3) {
            finaldepdate = (dateFormatterPrint2.string(from: date))
            print(finaldepdate)
        } else {
            print("There was an error decoding the string")
        }
        cell.DepAirportDate.text? = finaldepdate

        // converting arrivaldate to month day year
        //var finalarrdate = ""
        
        let arrdate = titleStringViaSegue[indexPath.row].flightSegment.arrival.at
        let arrdate2 = arrdate.index(arrdate.startIndex, offsetBy: 18)
        let arrdate3 = String(arrdate[...arrdate2])
        
        if let date = dateFormatterGet.date(from: arrdate3) {
            finalarrdate = (dateFormatterPrint2.string(from: date))
            print(finalarrdate)
        } else {
            print("There was an error decoding the string")
        }
        cell.ArrAirportDate.text? = finalarrdate
        cell.DepAirportAddress.text? = titleStringViaSegue[indexPath.row].flightSegment.departure.iataCode
        cell.ArrAirportAddress.text? = titleStringViaSegue[indexPath.row].flightSegment.arrival.iataCode

        // formatting total time value from 0DT2H20M to 2 h 20 m
        aString = titleStringViaSegue[indexPath.row].flightSegment.duration
        
        //var newString3 = ""
        let finalString = aString[aString.index(aString.startIndex, offsetBy: 0)]
        print("finalString \(finalString)")
        
        if (finalString == "0"){
            let newString = aString.replacingOccurrences(of: "H", with: " hrs ", options: .literal, range: nil)
            let newString2 = newString.replacingOccurrences(of: "M", with: " mins", options: .literal, range: nil)
            newString3 = newString2.replacingOccurrences(of: "0DT", with: "", options: .literal, range: nil)
            print("newString3 \(newString3)")
        }
        else {
            let newString = aString.replacingOccurrences(of: "H", with: " hrs ", options: .literal, range: nil)
            let newString2 = newString.replacingOccurrences(of: "M", with: " mins", options: .literal, range: nil)
            newString3 = newString2.replacingOccurrences(of: "DT", with: " day ", options: .literal, range: nil)
            print("newString3 \(newString3)")
        }
        
        cell.TotalTime.text? = newString3
        
     imageURL="http://www.gstatic.com/flights/airline_logos/70px/\(titleStringViaSegue[indexPath.row].flightSegment.carrierCode).png";
        print(imageURL)
        
        let url = URL(string: imageURL)!
        cell.FlightLogo.af_setImage(withURL: url)

        flightNameCode = (titleStringViaSegue[indexPath.row].flightSegment.carrierCode) + " " + (titleStringViaSegue[indexPath.row].flightSegment.number)
        cell.flightCode?.text = flightNameCode
        
        return cell
        }else {
            
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! TableViewCellForResult
            let service = titleStringViaSegue2
            
            let dayModel = titleStringViaSegue2[indexPath.section]
            let routineDayModel = dayModel.arrsegments[indexPath.row]
            
            let forDeparture = service[0].arrsegments.first
            let forArrival = service[1].arrsegments.first
            
            self.DepAirportName    = forDeparture!.flightSegment.departure.iataCode
            self.ArrAirportName    = forArrival!.flightSegment.departure.iataCode
            self.DepAirportTime    = forDeparture!.flightSegment.departure.at
            self.ArrAirportTime    = forArrival!.flightSegment.arrival.at
            self.DepAirportDate    = forDeparture!.flightSegment.departure.at
            self.ArrAirportDate    = forArrival!.flightSegment.arrival.at
            self.DepAirportAddress = forDeparture!.flightSegment.departure.iataCode
            self.ArrAirportAddress = forArrival!.flightSegment.arrival.iataCode
            self.TotalTime         = routineDayModel.flightSegment.duration
          
            self.isOneOrRound        = "roundwayselected"

            cell.DepAirportName?.text = routineDayModel.flightSegment.departure.iataCode
            cell.ArrAirportName?.text = routineDayModel.flightSegment.arrival.iataCode
            cell.DepAirportTime.text? = routineDayModel.flightSegment.departure.at
            cell.ArrAirportTime.text? = routineDayModel.flightSegment.arrival.at
            cell.DepAirportDate.text? = routineDayModel.flightSegment.departure.at
            cell.ArrAirportDate.text? = routineDayModel.flightSegment.arrival.at
            cell.DepAirportAddress.text? = routineDayModel.flightSegment.departure.iataCode
            cell.ArrAirportAddress.text? = routineDayModel.flightSegment.arrival.iataCode
            cell.TotalTime.text? = routineDayModel.flightSegment.duration

            
            dump("data of - \(dayModel)")
            print("data of - \(dayModel)")
            
            let imageURL2="http://www.gstatic.com/flights/airline_logos/70px/\(routineDayModel.flightSegment.carrierCode).png";
            print(imageURL2)

            let url = URL(string: imageURL2)!
            cell.FlightLogo.af_setImage(withURL: url)

            let flightNameCode2 = (routineDayModel.flightSegment.carrierCode) + " " + (routineDayModel.flightSegment.number)
            cell.flightCode?.text = flightNameCode2
            
            
            return cell
        }
            //return UITableViewCell()
            
        }
    
        

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedrow = indexPath.row
        
        //selectedrow
        
        print("You tapped cell number \(indexPath.row).")
    }

    
    
    @IBAction func finalSubmitBtn(_ sender: Any) {
        print("clicked.")
        
        let defaults = UserDefaults.standard
        

        defaults.set(DepAirportName,    forKey: "DepAirportName")
        defaults.set(ArrAirportName,    forKey: "ArrAirportName")
        defaults.set(DepAirportTime,    forKey: "DepAirportTime")
        defaults.set(ArrAirportTime,    forKey: "ArrAirportTime")
        defaults.set(DepAirportDate,    forKey: "DepAirportDate")
        defaults.set(ArrAirportDate,    forKey: "ArrAirportDate")
        defaults.set(DepAirportAddress, forKey: "DepAirportAddress")
        defaults.set(ArrAirportAddress, forKey: "ArrAirportAddress")
        defaults.set(TotalTime,         forKey: "TotalTime")
        defaults.set(FlightLogo,        forKey: "FlightLogo")
        defaults.set(flightName,        forKey: "flightName")
        defaults.set(flightCode,        forKey: "flightCode")
        defaults.synchronize()
        
            saveFIRData()
    }
    

    func saveFIRData(){
        let user = Auth.auth().currentUser
        
        if Auth.auth().currentUser != nil {
            self.ref.child(user!.uid).child("DepAirportName").setValue(DepAirportName)
            self.ref.child(user!.uid).child("ArrAirportName").setValue(ArrAirportName)
            self.ref.child(user!.uid).child("DepAirportTime").setValue(DepAirportTime)
            self.ref.child(user!.uid).child("ArrAirportTime").setValue(ArrAirportTime)
            self.ref.child(user!.uid).child("DepAirportDate").setValue(DepAirportDate)
            self.ref.child(user!.uid).child("ArrAirportDate").setValue(ArrAirportDate)
            self.ref.child(user!.uid).child("DepAirportAddress").setValue(DepAirportAddress)
            self.ref.child(user!.uid).child("ArrAirportAddress").setValue(ArrAirportAddress)
            self.ref.child(user!.uid).child("TotalTime").setValue(TotalTime)
            self.ref.child(user!.uid).child("FlightLogo").setValue(FlightLogo)
            self.ref.child(user!.uid).child("flightName").setValue(flightName)
            self.ref.child(user!.uid).child("flightCode").setValue(flightCode)
        } else {
            //self.performSegue(withIdentifier: "gotoLoginPage", sender: Any?)
            print("user need to login in first")
        }
        
    }
    
    
    @IBAction func addToCartBtn(_ sender: Any) {
        
        StructOperation.flightDetails.flightType = self.isOneOrRound
        StructOperation.flightDetails.totalfare = "\(totalFareVal)"
        

//        // Use them like regular Swift objects
//        let flight = FlightData()
//        flight.from = self.DepAirportName
//        flight.to = self.ArrAirportName
//        flight.jdate = self.DepAirportDate
//        flight.rdate = self.ArrAirportDate
//        flight.flighttype = self.isOneOrRound
//        flight.flightfare = totalFareVal
//
//
//        getRealm { (realm) in
//            try! realm.write {
//                realm.add(flight)
//                print(flight)
//            }
//        }

//        print("data inserted")
        
        
        
        //customAlert()
        
        StructOperation.FlightOrHotel.comingfrom = "Flight"
//
//        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
//
//        self.navigationController?.pushViewController(secondVC, animated: true)
        
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HView2") as! HView2
        
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        
    }
    
}
    
