//
//  HomeViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 06/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import RealmSwift
import Foundation

protocol MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?)
    func reopenMenu()
}

class HomeViewController: UIViewController, DataPass, DataPass3, DataPass4, DataPass5, CalendarCallBack {
    
    let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF)
    let pinkColor = UIColor(rgb: 0xF43477)
    
    let interactor = Interactor()
    
    
    let dollarSign = "\u{24}"
    @IBOutlet weak var flightBtn: UIButton!
    @IBOutlet weak var hotelBtn: UIButton!
    @IBOutlet weak var carBtn: UIButton!
    @IBOutlet weak var vacationBtn: UIButton!
    @IBOutlet weak var activityBtn: UIButton!
    
    @IBOutlet weak var flightSearchBtn: UIButton!
    @IBOutlet weak var hotelSearchBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    @IBOutlet weak var containerView1: UIView!
    @IBOutlet weak var containerView2: UIView!
    
    @IBOutlet weak var SubView: UIView!
    @IBOutlet weak var JDateView: ANCustomView!
    @IBOutlet weak var RDateView: ANCustomView!
    @IBOutlet weak var date1: UIButton!
    @IBOutlet weak var date2: UIButton!
    @IBOutlet weak var journeyDay: UILabel!
    @IBOutlet weak var returnDay: UILabel!

    @IBOutlet weak var viewForSegmented: UIView!
    
    @IBOutlet weak var originView: UIView!
    @IBOutlet weak var destiView: UIView!
    @IBOutlet weak var originBtn: UIButton!
    @IBOutlet weak var destiBtn: UIButton!
    @IBOutlet weak var originDetail: UILabel!
    @IBOutlet weak var destiDetail: UILabel!
    
    @IBOutlet weak var tripImage: UIImageView!
    @IBOutlet weak var hotelView1: UIView!
    @IBOutlet weak var hotelView2: UIView!
    @IBOutlet weak var hotelView3: UIView!
    @IBOutlet weak var hDate1: UIButton!
    @IBOutlet weak var hDate1day: UILabel!
    @IBOutlet weak var hdate2: UIButton!
    @IBOutlet weak var hdate2day: UILabel!
    
    @IBOutlet weak var searchHotelLoc: UIButton!
    @IBOutlet weak var classPassBtn: UIView!
    @IBOutlet weak var roomsLbl: UILabel!
    @IBOutlet weak var guestLbl: UILabel!
    @IBOutlet weak var classTypeLbl: UILabel!
    @IBOutlet weak var passengerLbl: UILabel!
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    
    var selectedDate = Date()
    var tagLabel:Int = 0
    var tagLabel1:Int = 0
    var tripSelectionVal = ""

    var getMyLabel : Int = 0
    var getMyLabel2 : Int = 0
    
    
    var finalSource = "MAD"
    var finalDestination = "PAR"
    var depDate = ""
    var retDate = ""
    var tripType = "One Way"
    var classType = "ECONOMY"
    var depDateFinal = ""
    var depDateFinal2 = ""
    var depDayFinal = ""
    var retDateFinal = ""
    var retDateFinal2 = ""
    var retDayFinal = ""
    var adultVal = "1"
    var childVal = "0"
    var infantVal = "0"
    var AccessToken = ""
    var data = ""
    var totalPassengerCount:Int = 1
    
    var hotelLocname = "Location"
    var rooms = "1"
    var adults = "1"
    var childs = "0"
    var totalGuestsCount:Int = 1
    var username = "fromBack"
    
    var uid = ""
    var email = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.navigationController?.isNavigationBarHidden = false;
        createSegmented()
        //localPost()
    
        //self.viewForSegmented.bringSubview(toFront: containerView2)
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        flightBtn.alpha = 0.7
        hotelBtn.alpha = 0.7
        carBtn.alpha = 0.7
        vacationBtn.alpha = 0.7
        activityBtn.alpha = 0.7
        
//
//        containerView1.layer.applySketchShadow(
//            color: .black,
//            alpha: 0.2,
//            x: 0,
//            y: 4,
//            blur: 21,
//            spread: 5)
//
//        containerView2.layer.applySketchShadow(
//            color: .black,
//            alpha: 0.2,
//            x: 0,
//            y: 4,
//            blur: 21,
//            spread: 5)
        
        // Shantanu Sir's choice grey icons
        let origImage = UIImage(named: "cal")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        img1.image = tintedImage
        img1.tintColor = .lightGray

        img2.image = tintedImage
        img2.tintColor = .lightGray

        let origImage2 = UIImage(named: "guest")
        let tintedImage2 = origImage2?.withRenderingMode(.alwaysTemplate)
        img3.image = tintedImage2
        img3.tintColor = .lightGray

        
//        containerView1.center.x = self.view.center.x
//        
//        containerView2.center.x = self.view.center.x
        
        
        let originLoc: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapOriginView))
        originView.addGestureRecognizer(originLoc)
        originLoc.delegate = self as? UIGestureRecognizerDelegate
        
        
        let destiLoc: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapOriginView))
        destiView.addGestureRecognizer(destiLoc)
        destiLoc.delegate = self as? UIGestureRecognizerDelegate
        
        
        let tap4: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapLabelDemo4))
        classPassBtn.addGestureRecognizer(tap4)
        tap4.delegate = self as? UIGestureRecognizerDelegate
        
        
        let roomguest: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(roomguestTapped))
        hotelView3.addGestureRecognizer(roomguest)
        roomguest.delegate = self as? UIGestureRecognizerDelegate
        
        
        let JDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dateSelection))
        JDateView.addGestureRecognizer(JDateViewTap)
        JDateViewTap.delegate = self as? UIGestureRecognizerDelegate

        let RDateViewTap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dateSelection))
        RDateView.addGestureRecognizer(RDateViewTap)
        RDateViewTap.delegate = self as? UIGestureRecognizerDelegate

        let hotelView1Tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dateSelection))
        hotelView1.addGestureRecognizer(hotelView1Tap)
        hotelView1Tap.delegate = self as? UIGestureRecognizerDelegate

        let hotelView2Tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(dateSelection))
        hotelView2.addGestureRecognizer(hotelView2Tap)
        hotelView2Tap.delegate = self as? UIGestureRecognizerDelegate
        
        
        drawLineFromPoint(start: CGPoint(x:0, y: SubView.bounds.height / 2), toPoint: CGPoint(x: SubView.bounds.width, y: SubView.bounds.height / 2), ofColor: UIColor.lightGray, inView: SubView)
        
        
        
        
        // getting current date
        let today = NSDate()
        // adding 3 days to current date
        
        let currentDateplus1Day = NSDate(timeIntervalSinceNow: 86400 * 1)
        let currentDateplus3Days = NSDate(timeIntervalSinceNow: 86400 * 3)
        let currentDateplus5Days = NSDate(timeIntervalSinceNow: 86400 * 5)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "EE"
        
        let dateset1 = (dateFormatter.string(from: currentDateplus3Days as Date))
        let dateset2 = (dateFormatter.string(from: currentDateplus5Days as Date))
        let dateset3 = (dateFormatter.string(from: currentDateplus1Day as Date))
         let dateset4 = (dateFormatter.string(from: today as Date))
        
        let Jday = (dateFormatter2.string(from: currentDateplus3Days as Date))
        let Rday = (dateFormatter2.string(from: currentDateplus5Days as Date))
        
        let HJday2 = (dateFormatter2.string(from: today as Date))
        let HRday2 = (dateFormatter2.string(from: currentDateplus1Day as Date))
        
        //originBtn.setTitle("From", for: .normal)
        //destiBtn.setTitle("To", for: .normal)
        
        date1.setTitle(dateset1, for: .normal)
        date2.setTitle(dateset2, for: .normal)
        hDate1.setTitle(dateset4, for: .normal)
        hdate2.setTitle(dateset3, for: .normal)
        
        journeyDay.text = Jday
        returnDay.text = Rday
        
        hDate1day.text = HJday2
        hdate2day.text = HRday2
        
       
        
        searchHotelLoc.setTitle(self.hotelLocname, for: .normal)
        roomsLbl.text = self.rooms + "Rooms"
        guestLbl.text = adults + "Guests"
        hDate1day.text = "Date"
        hdate2day.text = "Date"
    
    }
    

    func createSegmented(){
        let items = ["One Way" , "Round Trip"]
        let segmentedControl = UISegmentedControl(items : items)
        segmentedControl.center = self.viewForSegmented.center
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(HomeViewController.indexChanged(_:)), for: .valueChanged)
        
        segmentedControl.backgroundColor = .white
        segmentedControl.tintColor = pinkColor
        
        self.containerView2.addSubview(segmentedControl)
    }
    
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
//        case 0:
//            print("One Way");
//        case 1:
//            print("Round Trip")
//        default:
//            break
//        }
//
        
        case 0:
        self.tripType = "One Way"
        print("One Way")
        self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.white, inView: self.SubView)
        UIView.animate(withDuration: 0.3, animations: {
        self.RDateView.center.x = self.SubView.center.x
        self.JDateView.center.x = self.SubView.center.x
        self.RDateView.isHidden = true
        self.tripImage.image = UIImage(named: "oneway")
        })
        
        
        case 1:
        self.tripType = "Round Trip"
        print("Round Trip")
        UIView.animate(withDuration: 0.3, animations: {
        self.RDateView.isHidden = false
        self.JDateView.center.x = self.SubView.center.x - 85
        self.RDateView.center.x = self.SubView.center.x + 85
        self.tripImage.image = UIImage(named: "roundtrip")
        
        self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.lightGray, inView: self.SubView)
        })
        
        
        default:
        self.tripType = "One Way"
        print("One Way")
        self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.white, inView: self.SubView)
        UIView.animate(withDuration: 0.3, animations: {
        self.RDateView.center.x = self.SubView.center.x
        self.JDateView.center.x = self.SubView.center.x
        self.RDateView.isHidden = true
        self.tripImage.image = UIImage(named: "oneway")
        })
        
    }
    }
    
    
    func drawLineFromPoint(start : CGPoint, toPoint end:CGPoint, ofColor lineColor: UIColor, inView view:UIView) {
        
        //design the path
        var path = UIBezierPath()
        path.move(to: start)
        path.addLine(to: end)
        
        //design path in layer
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = lineColor.cgColor
        shapeLayer.lineWidth = 0.3
        
        view.layer.addSublayer(shapeLayer)
    }
    
    
//    func localPost(){
//        
//        let user = Auth.auth().currentUser
//        if let user = user {
//        
//            self.uid = user.uid
//            self.email = user.email!
//         
//        }
//        
//        let parameters: [String: Any] = [
//            "user_id" : "\(self.uid)",
//            "pnr_number" : "\(self.uniqueID)"
//        ]
//        
//        Alamofire.request("http://192.168.1.247:8082/travanda/Booking.php", method: .post, parameters: parameters, encoding: JSONEncoding.default)
//            .responseJSON { response in
//                print("Response from shantanu sir - \(response)")
//        }
//        
//    }
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = .white
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    @IBAction func actBtn(_ sender: Any) {
        showToast(controller: self, message: "Empty", seconds: 1)
    }
    
    @IBAction func edgePanGesture(_ sender: UIScreenEdgePanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        let progress = MenuHelper.calculateProgress(translation, viewBounds: view.bounds, direction: .right)
        
        MenuHelper.mapGestureStateToInteractor(
            sender.state,
            progress: progress,
            interactor: interactor){
                self.performSegue(withIdentifier: "openMenu", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationViewController = segue.destination as? MenuViewControllerSideBar {
            destinationViewController.transitioningDelegate = self
            destinationViewController.interactor = interactor
            destinationViewController.menuActionDelegate = self
        }
        
        if(segue.identifier == "resultsegue"){
            
            let navController = segue.destination as! UINavigationController
            let displayVC = navController.topViewController as! ResultViewController
            
            displayVC.mySource = finalSource
            displayVC.myDest = finalDestination
            displayVC.myAdult = adultVal
            displayVC.myChild = childVal
            displayVC.myTickettype = classType
            displayVC.mytripType = tripType
            
            displayVC.myDate = self.date1.currentTitle!
            displayVC.myDate2 = self.date2.currentTitle!
            
            StructOperation.flightDetails.from = finalSource
            StructOperation.flightDetails.to = finalDestination
            StructOperation.flightDetails.departDate = self.date1.currentTitle!
            StructOperation.flightDetails.returnDate = self.date2.currentTitle!
            StructOperation.flightDetails.adults = adultVal
            StructOperation.flightDetails.children = childVal
            StructOperation.flightDetails.infants = infantVal
            StructOperation.flightDetails.classtype = classType
            StructOperation.flightDetails.totalTraveller = self.totalPassengerCount
            
        }
        
        if(segue.identifier == "hotelsegue"){
            let nextView = segue.destination as! UINavigationController
            let displayVC = nextView.topViewController as! HotelSearchViewViewController
            
            displayVC.location = searchHotelLoc.currentTitle!
            displayVC.checkindate = hDate1.currentTitle!
            displayVC.checkoutdate = hdate2.currentTitle!
            displayVC.totalroom = roomsLbl.text!
            displayVC.totalguest = guestLbl.text!
            
            StructOperation.glovalVariable.location = searchHotelLoc.currentTitle!
            StructOperation.glovalVariable.checkin = hDate1.currentTitle!
            StructOperation.glovalVariable.checkout = hdate2.currentTitle!
            StructOperation.glovalVariable.totalroom = roomsLbl.text!
            StructOperation.glovalVariable.totalguest = self.totalGuestsCount
            StructOperation.glovalVariable.adult = self.adults
            StructOperation.glovalVariable.child = self.childs
        }
        
    }
    
    
    
//    // MARK:- For getting Trip Type
//    @IBAction func customSegmentedValueChanged(_ sender: CustomSegmentedControl) {
//        print("sender.selectedSegmentedIndex\(sender.selectedSegmentedIndex)")
//        switch sender.selectedSegmentedIndex {
//
//        case 0:
//            self.tripType = "One Way"
//
//            print("One Way")
//            self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.white, inView: self.SubView)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.RDateView.center.x = self.SubView.center.x
//                self.JDateView.center.x = self.SubView.center.x
//                self.RDateView.isHidden = true
//                self.tripImage.image = UIImage(named: "oneway")
//
//
//
//            })
//        case 1:
//            self.tripType = "Round Trip"
//            print("Round Trip")
//            UIView.animate(withDuration: 0.3, animations: {
//                self.RDateView.isHidden = false
//                self.JDateView.center.x = self.SubView.center.x - 68
//                self.RDateView.center.x = self.SubView.center.x + 55
//                self.tripImage.image = UIImage(named: "roundtrip")
//
//                self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.lightGray, inView: self.SubView)
//            })
//
//
//
//
//        default:
//            self.tripType = "One Way"
//            print("One Way")
//            self.drawLineFromPoint(start: CGPoint(x:self.SubView.bounds.width / 2, y: 0), toPoint: CGPoint(x: self.SubView.bounds.width / 2, y: self.SubView.bounds.height / 2), ofColor: UIColor.white, inView: self.SubView)
//            UIView.animate(withDuration: 0.3, animations: {
//                self.RDateView.center.x = self.SubView.center.x
//                self.JDateView.center.x = self.SubView.center.x
//                self.RDateView.isHidden = true
//                self.tripImage.image = UIImage(named: "oneway")
//
//
//            })
//        }
//    }
//

    // MARK:- For getting origin location
    @objc func didTapOriginView(sender: UITapGestureRecognizer)
    {
        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        secondVC.delegate = self
        self.navigationController?.pushViewController(secondVC, animated: true)
         getMyLabel2 = sender.view!.tag
    }
    
    func dataPassing(name: String) {
        if (getMyLabel2 == 400){
            self.finalSource = name
        }
        if (getMyLabel2 == 401){
            self.finalDestination = name
        }
        if (getMyLabel2 == 402){
            self.hotelLocname = name
        }
       
        
    }

    
    // MARK:- For getting Passenger details
    @objc func didTapLabelDemo4(sender: UITapGestureRecognizer)
    {
        
        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let secondVC3 = nextstoryboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        
        secondVC3.delegate3 = self
        self.navigationController?.pushViewController(secondVC3, animated: true)
    }
    
    func dataPassing3(adult: String, child: String, infant: String, classType: String) {
        self.adultVal = adult
        self.childVal = child
        self.infantVal = infant
        self.classType = classType
    }

    
    
    // MARK:- For getting Hotel Location Place Name
    @IBAction func searchHotelLoc(_ sender: Any) {
        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let secondVC4 = nextstoryboard.instantiateViewController(withIdentifier: "SearchFormHotel") as! SearchFormHotel
        
        secondVC4.delegate4 = self
        self.navigationController?.pushViewController(secondVC4, animated: true)
    }
    
    func dataPassing4(name4: String) {
        self.hotelLocname = name4
    }
   

    
    
    @objc func roomguestTapped(sender: UITapGestureRecognizer)
    {
        print("Guest CLICKED")
        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let secondVC5 = nextstoryboard.instantiateViewController(withIdentifier: "RoomGuestForm") as! RoomGuestForm
        
        secondVC5.delegate5 = self
        self.navigationController?.pushViewController(secondVC5, animated: true)
    }
    
    func dataPassing5(rooms: String, adults: String, childs: String) {
        self.rooms = rooms
        self.adults = adults
        self.childs = childs
    }
    
    
    @objc func dateSelection(sender: UITapGestureRecognizer) {
        print("clicked2")
        
        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        
        let CalendarViewController = nextstoryboard.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        CalendarViewController.modalPresentationStyle = .overCurrentContext
        CalendarViewController.delegate = self
        CalendarViewController.selectedDate = selectedDate
        self.present(CalendarViewController, animated: false, completion: nil)
        
        getMyLabel = sender.view!.tag
    }
    

    
    
    func didSelectDate(date: Date) {
        selectedDate = date
        
        if (getMyLabel == 200){
            date1.setTitle((date.getTitleDateFC()),for: .normal)
            journeyDay.text = date.getTitleDay()
        }
        if (getMyLabel == 201){
            date2.setTitle((date.getTitleDateFC()),for: .normal)
            returnDay.text = date.getTitleDay()
        }
        
        if (getMyLabel == 300){
            hDate1.setTitle((date.getTitleDateFC()),for: .normal)
            hDate1day.text = date.getTitleDay()
            hDate1day.isHidden = false
        }
        
        if (getMyLabel == 301){
            hdate2.setTitle((date.getTitleDateFC()),for: .normal)
            hdate2day.text = date.getTitleDay()
            hdate2day.isHidden = false
        }
        
        
    }
    


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        
        self.navigationController?.isNavigationBarHidden = false;
        
        //self.classTypeLbl.text = self.classType
        //self.passengerLbl.text = String(self.totalPassengerCount) + " Passengers"
        
        let finalSourceSub = finalSource.prefix(3)

        let finalDestinationSub = finalDestination.prefix(3)
        
        self.originBtn.setTitle(String(finalSourceSub), for: .normal)
        self.destiBtn.setTitle(String(finalDestinationSub), for: .normal)
        
        self.classTypeLbl.text = classType
        
        let myInt = (adultVal as NSString).integerValue
        let myInt2 = (childVal as NSString).integerValue
        totalPassengerCount = myInt + myInt2
        
        self.passengerLbl.text = String(totalPassengerCount) + " Passengers"
        
        self.searchHotelLoc.setTitle(self.hotelLocname, for: .normal)
        self.roomsLbl.text = self.rooms + " Rooms"
        
        let myInt3 = (adults as NSString).integerValue
        let myInt4 = (childs as NSString).integerValue
        totalGuestsCount = myInt3 + myInt4
        
        self.guestLbl.text = String(totalGuestsCount) + " Guests"
        
       
        
    }
    
    

    // MARK:- All Button Action flight, Hotel, Cars etc
    @IBAction func showView(sender: UIButton) {
        switch sender {
        case flightBtn:
             print ("flight tapped")
             self.flightBtn.alpha = 1
//             if (containerView1.alpha == CGFloat(1)){
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                self.containerView2.alpha = 1
//                self.containerView2.frame.origin.y = self.containerView1.frame.size.height + 20
//                    self.containerView2.frame.size.height = 342;
//
//                })
//            }
//             else if (containerView1.alpha == CGFloat(0)){
//                UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                    self.containerView2.alpha = 1
//                    //self.containerView2.frame.origin.y = self.containerView1.frame.size.height + 20
//                    self.containerView2.frame.size.height = 342;
//            })
//            }
             

             UIView.animate(withDuration: 0.5, delay: 0, animations: {
                 self.containerView2.alpha = 1
                 self.flightSearchBtn.alpha = 1
                 self.containerView1.alpha = 0
                 self.hotelSearchBtn.alpha = 0
                
            })
            
            
        case hotelBtn:

            print ("hotel tappeed")
            self.hotelBtn.alpha = 1
//            if (containerView2.alpha == CGFloat(1)){
//            UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                self.containerView1.alpha = 1
//                 self.containerView1.frame.origin.y = self.containerView2.frame.size.height + 20
//                self.containerView1.frame.size.height = 222;
//                //self.containerView2.alpha = 0
//            })
//            }
//            else if (containerView2.alpha == CGFloat(0)){
//                UIView.animate(withDuration: 0.5, delay: 0, animations: {
//                    self.containerView1.alpha = 1
//                    //self.containerView1.frame.origin.y = self.containerView2.frame.size.height + 20
//                    self.containerView1.frame.size.height = 222;
//                    //self.containerView2.alpha = 0
//                })
//            }
//
            UIView.animate(withDuration: 0.5, delay: 0, animations: {
                self.containerView1.alpha = 1
                self.hotelSearchBtn.alpha = 1
                self.containerView2.alpha = 0
                self.flightSearchBtn.alpha = 0
            })
                
        case carBtn:
            
            print ("car tap")
        default:
            break

        }

    }
    

    @IBAction func closeBtnFlight(_ sender: Any) {
        self.containerView2.alpha = 0
        self.hotelSearchBtn.alpha = 0
        self.flightSearchBtn.alpha = 0
        //self.containerView1.frame.origin.y = 0
        self.flightBtn.alpha = 0.7
        self.hotelBtn.alpha = 0.7
    }
    
    
    @IBAction func closeBtnHotel(_ sender: Any) {
        self.containerView1.alpha = 0
        self.hotelSearchBtn.alpha = 0
        self.flightSearchBtn.alpha = 0
        //self.containerView2.frame.origin.y = 0
        self.hotelBtn.alpha = 0.7
        self.flightBtn.alpha = 0.7
    }
    
    
 
    @IBAction func menuTapped(_ sender: Any) {
   
        print("menu pressed")
        performSegue(withIdentifier: "openMenu", sender: nil)
        
    }
    
    
    @IBAction func carTapped(_ sender: Any) {
   
        print("add pressed")

        let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    

    @objc func back(sender: UIBarButtonItem) {
        print("pressed back button not via segue")
        _ = navigationController?.popViewController(animated: true)
    }
    
    
 

    @IBAction func searchFlightBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "resultsegue", sender: self)

        }
    
    
    @IBAction func searchHotelBtn(_ sender: Any) {
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HotelSearchViewViewController") as! HotelSearchViewViewController
        self.navigationController?.pushViewController(listVc, animated: true)
        
    }
    
}



extension HomeViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentMenuAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissMenuAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor.hasStarted ? interactor : nil
    }
}

extension HomeViewController : MenuActionDelegate {
    func openSegue(_ segueName: String, sender: AnyObject?) {
        dismiss(animated: true){
            self.performSegue(withIdentifier: segueName, sender: sender)
        }
    }
    func reopenMenu(){
        performSegue(withIdentifier: "openMenu", sender: nil)
    }
}


extension CALayer {
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
