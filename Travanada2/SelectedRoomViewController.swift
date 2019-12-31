//
//  SelectedRoomViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 29/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON
import RealmSwift

class CustomHotelCell1: UITableViewCell{
    @IBOutlet var HotelName: UILabel!
    @IBOutlet var HotelAddress: UILabel!
    @IBOutlet var HotelRating: UILabel!
    @IBOutlet var HotelDistance: UILabel!
    @IBOutlet var HotelCity: UILabel!

    @IBOutlet weak var HotelImage: UIImageView!

    @IBOutlet weak var HotelDescription: UITextView!

    @IBOutlet var HotelAmenities1: UIImageView!
    @IBOutlet var HotelAmenities2: UIImageView!
    @IBOutlet var HotelAmenities3: UIImageView!
    @IBOutlet var HotelAmenities4: UIImageView!
    @IBOutlet var HotelAmenities5: UIImageView!
    @IBOutlet var HotelAmenities6: UIImageView!

}

class SelectedRoomViewController: UIViewController {

    var hotelId = ""
    var nextroomurl = ""
    var accessToken = ""
    var approxPrice = ""
    
    var valueToPass:String!
    
    var offerarray:Offer! = nil
    
    @IBOutlet var HotelName: UILabel!
    @IBOutlet var HotelAddress: UILabel!
    @IBOutlet var HotelRating: UILabel!
    @IBOutlet var HotelDistance: UILabel!
    @IBOutlet var HotelCity: UILabel!
    
    @IBOutlet weak var HotelImage: UIImageView!
    
    @IBOutlet weak var HotelDescription: UITextView!

    @IBOutlet var HotelAmenities1: UIImageView!
    @IBOutlet var HotelAmenities2: UIImageView!
    @IBOutlet var HotelAmenities3: UIImageView!
    @IBOutlet var HotelAmenities4: UIImageView!
    @IBOutlet var HotelAmenities5: UIImageView!
    @IBOutlet var HotelAmenities6: UIImageView!
    
    var arrData = SelectedRoomDataModel()
    
    var yourArray = [AnyObject]()
    
    let section = ["Detail", "Room Images", "Description", "Faclities", "Select Room Type"]
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var fareLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Avalaible Room"
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        print("hotelId\(hotelId)")
        print("nextroomurl\(nextroomurl)")
        print("accessToken\(accessToken)")
        
        tableView.register(UINib(nibName: "Hview2Cell", bundle: nil), forCellReuseIdentifier: "Hview2Cell")
    
        self.getData(accessToken: self.accessToken)
        fareLbl?.text = self.approxPrice
        
    }
    


    @objc func buttonActionCart(_ sender: UIButton!) {
        print("Cart tapped")
    }
    
    @objc func buttonActionBook(_ sender: UIButton!) {
        print("Book tapped")
    }
    
    
    func getData(accessToken:String) {
        
        var responseReturn:Any?
        
        let url2 = "https://test.api.amadeus.com/v2/shopping/hotel-offers/by-hotel?hotelId=\(hotelId)"
        
        print("urllll-\(url2)")
        
        
        let headers2 : HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        Alamofire.request(url2, method: .get,encoding:JSONEncoding.default,headers: headers2).responseJSON{
            (response) -> Void in
            

            
            if response.result.isSuccess {

                let responseData = response.data!
                do{
                    if(JSON(response.result.value!) != nil){
                        let resJSON = JSON(response.result.value!)
                         print("roomdata- \(resJSON["data"])")
     
                        self.arrData.setdata(dictJson: resJSON["data"])
                        
                        let offercount = self.arrData.arroffers.count
                        
                         print("offercount- \(offercount)")
                        if(offercount != 0)
                        {
                            self.setDatatoView()
                            let boo = resJSON["data"]
                            print("arrData- \(self.arrData)")
                            print("arrData- \(boo)")
                            
                            OperationQueue.main.addOperation({
                                self.tableView.reloadData()
                            })
                        }else
                        {
                            // create the alert
                            let alert = UIAlertController(title: "Sorry!!", message: "No Rooms Available", preferredStyle: UIAlertControllerStyle.alert)
                            // add an action (button)
                            alert.addAction(UIAlertAction(title: "Select Another", style: UIAlertActionStyle.default, handler: { action in
                               
                                self.navigationController?.popViewController(animated: true)
                           
                            }))
                            
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                       
                    }
                    else {
                        print("Sorry No Rooms Available")
                        self.navigationController?.popViewController(animated: true)
                    }
                }catch{
                    print (error)
                }
                print("get request for ur json \(response)")

            }
            else {
                print("Error \(String(describing: response.result.error))")
                responseReturn=response
                print(responseReturn ??   "")
            }
            
            }.resume()
        
    }
   
    func setDatatoView(){
        HotelName.text = self.arrData.hotel2.name
        HotelAddress.text = self.arrData.hotel2.address.cityName + self.arrData.hotel2.address.countryCode
        
        var ratingVal = self.arrData.hotel2.rating
        
        if (ratingVal == "1"){
            HotelRating?.text = "*"
        }
        if (ratingVal == "2"){
            HotelRating?.text = "**"
        }
        if (ratingVal == "3"){
            HotelRating?.text = "***"
        }
        if (ratingVal == "4"){
            HotelRating?.text = "****"
        }
        if (ratingVal == "5"){
            HotelRating?.text = "*****"
        }
        
    
        HotelCity.text = self.arrData.hotel2.address.cityName
        
        let imageURL = "http://pdt.multimediarepository.testing.amadeus.com/cmr/retrieve/hotel/BD22BCF4BBFF402185AEE37F6230B8F4"
        print(imageURL)
        
        let url = URL(string: imageURL)!
        HotelImage.af_setImage(withURL: url)
        
        HotelDescription?.text = self.arrData.arroffers[0].room.roomDescription.text
        HotelAmenities1?.image = UIImage(named: "facility1")
        HotelAmenities2?.image = UIImage(named: "facility2")
        HotelAmenities3?.image = UIImage(named: "facility3")
        HotelAmenities4?.image = UIImage(named: "facility4")
        HotelAmenities5?.image = UIImage(named: "facility5")
        HotelAmenities6?.image = UIImage(named: "facility6")
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
            
//            let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "GuestNames") as! GuestNames
//
//            self.navigationController?.pushViewController(secondVC, animated: true)
            
            
            StructOperation.FlightOrHotel.comingfrom = "Hotel"
            let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
            
            self.navigationController?.pushViewController(secondVC, animated: true)
            
            
        }
        
        // Add the actions
        alertController.addAction(addmore)
        alertController.addAction(goToCart)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func bookNowBtn(_ sender: Any) {
        
    }
    
}


extension SelectedRoomViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrData.arroffers.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 148.0
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:Hview2Cell = self.tableView.dequeueReusableCell(withIdentifier: "Hview2Cell") as! Hview2Cell

        let offerarray = self.arrData.arroffers
   
        cell.roomcat?.text = offerarray[indexPath.row].room.typeEstimated.category
        cell.roombed?.text = offerarray[indexPath.row].room.typeEstimated.beds
        cell.bedtype?.text = offerarray[indexPath.row].room.typeEstimated.bedType
        cell.adults?.text = offerarray[indexPath.row].guests.adults
        cell.fare?.text = ("\(offerarray[indexPath.row].price.currency)  \(offerarray[indexPath.row].price.total)")
        
        return cell

    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let row = indexPath.row
        self.offerarray = self.arrData.arroffers[row]
        
        
        
    
//        print(offerarray.guests.adults)
//        print(offerarray.room.typeEstimated.category)
//        print(offerarray.room.typeEstimated.beds)
//        print(offerarray.room.typeEstimated.bedType)
//        print(offerarray.price.total)
//        print(offerarray.price.currency)
//
//        print(self.HotelName.text!)
//        print(self.HotelAddress.text!)
//        print(self.HotelRating.text!)
//        print(self.HotelDistance.text!)
//        print(self.HotelCity.text!)
        
        StructOperation.glovalVariable.hotelFare = offerarray.price.total
        StructOperation.glovalVariable.hotelname = self.arrData.hotel2.name
        StructOperation.glovalVariable.hotelAddressCity = (self.arrData.hotel2.address.cityName + self.arrData.hotel2.address.countryCode)
        
        addToCratBtn()
        
        
    }
    
    
    func addToCratBtn() {
        // Use them like regular Swift objects
//        let hotel = HotelData()
//        hotel.location = HotelAddress.text!
//        hotel.checkin = StructOperation.glovalVariable.checkin
//        hotel.checkout = StructOperation.glovalVariable.checkout
//        hotel.room = StructOperation.glovalVariable.totalroom
//        hotel.totalGuest = StructOperation.glovalVariable.totalguest
//        hotel.hotelfare = self.offerarray.price.total
//        hotel.hotelname = self.HotelName.text!
//        
//        
//        getRealm { (realm) in
//            try! realm.write {
//                realm.add(hotel)
//                print(hotel)
//            }
//        }
//        
//        print("data inserted")
        //customAlert()
        
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "GuestNames") as! GuestNames

        self.navigationController?.pushViewController(secondVC, animated: true)
        
        
    }
    
    
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
//
//        if (segue.identifier == "yourSegueIdentifer") {
//            // initialize new view controller and cast it as your view controller
//            var viewController = segue.destinationViewController as AnotherViewController
//            // your new view controller should have property that will store passed value
//            viewController.passedValue = valueToPass
//        }
//    }
//
    

}
