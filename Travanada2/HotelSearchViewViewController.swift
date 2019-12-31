//
//  HotelSearchViewViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 03/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class HotelSearchViewViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var AccessToken:String = ""
    var arrData = [HotelSearch]()
    var location = ""
    var checkindate = ""
    var checkoutdate = ""
    var totalroom = ""
    var totalguest = ""
    
    var finallocation = ""
    var finalguest = ""
    
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        postRequest()
        finallocation = String(location.prefix(3))
        finalguest = String(totalguest.prefix(1))
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.transform = transform
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
    }
    
    
    override func viewDidLayoutSubviews() {
        
        let firstLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
        firstLabel.text = "Hotel For \(StructOperation.glovalVariable.location.prefix(3)) \n \(StructOperation.glovalVariable.checkin) - \(StructOperation.glovalVariable.checkout)"
        firstLabel.numberOfLines = 2
        firstLabel.textAlignment = .center
        firstLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
        firstLabel.textColor = UIColor.white
        firstLabel.sizeToFit()
        self.navigationItem.titleView = firstLabel
        
    }
    
    
    @IBAction func backToHome(_ sender: Any) {
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(listVc, animated: true)
    }
    
    
    // MARK : - POST request for authentication using credentials
    func postRequest()
    {
        let headers: HTTPHeaders = ["Content-Type": "application/x-www-form-urlencoded",]
        
        let parameters: Parameters = [
            "client_id":"cdvk9Ktc9Ud9RddiQqb5ip5BRhG0GAiA",
            "client_secret":"Me86Yjsf3tngKisE",
            "grant_type":"client_credentials"]
        
        let url = "https://test.api.amadeus.com/v1/security/oauth2/token"
        
        Alamofire.request(url, method:.post, parameters:parameters, headers:headers).responseJSON { response in
            
            switch response.result {
            case .success(let JSON):
                debugPrint(response)

                print("Success with JSON: \(JSON)")

                let response = JSON as! NSDictionary

                //example if there is an id
                self.AccessToken = response.object(forKey: "access_token")! as? String ?? ""
                self.getData(accessToken: self.AccessToken)

            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
        print("after sucess compiled- \(AccessToken)")
    }
    
    
    
    func customAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "Travanada", message: "Time Session Out!", preferredStyle: .alert)
        
        // Create the actions
        let addmore = UIAlertAction(title: "Search Again", style: UIAlertActionStyle.default) {
            
            UIAlertAction in
            NSLog("OK Pressed")
            
            let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.pushViewController(listVc, animated: true)
            
        }
      
        
        // Add the actions
        alertController.addAction(addmore)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
    // MARK : - Get request for receiving response from server and parsing data
    
    func getData(accessToken:String) {
        
        var responseReturn:Any?
        
        let url2 = "https://test.api.amadeus.com/v2/shopping/hotel-offers?cityCode=\(finallocation)&adults=\(finalguest)"
   
        print("urllll-\(url2)")
        
        
        let headers2 : HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        Alamofire.request(url2, method: .get,encoding:JSONEncoding.default,headers: headers2).responseJSON{
            (response) -> Void in
            
            
            
            if response.result.isSuccess {
                
                self.activityIndicator.stopAnimating()
                let resJSON = JSON(response.result.value!)
                var dictCount = resJSON["data"].count
                if(dictCount != 0)
                {
                    for dictData in resJSON["data"].arrayValue {
                        let data = HotelSearch()
                         data.setdata(dictJson: dictData.dictionaryValue)
                         self.arrData.append(data)
                        print("get request for ur json \(response)")
                    }
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                }else
                {
                    self.loadLabel()
                }
                return
            }
            if response.result.isFailure {
                print("Server error")
                return
            }
            
            
            }.resume()
        
    }
    
    func loadLabel(){
        let message = UILabel()
        message.text = "No Result Found!! Please Search Again..."
        message.translatesAutoresizingMaskIntoConstraints = false
        message.lineBreakMode = .byWordWrapping
        message.numberOfLines = 0
        message.textAlignment = .center
        
        self.view.addSubview(message)
        
        message.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        message.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        message.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    

}


extension HotelSearchViewViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrData.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

         let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! HotelSearchTableViewCell
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        
        cell.HotelDistance?.text = (self.arrData[indexPath.row].hotel.hotelDistance.distance) + (self.arrData[indexPath.row].hotel.hotelDistance.distanceUnit)
        
         cell.HotelName?.text = self.arrData[indexPath.row].hotel.name
  
        var ratingVal = self.arrData[indexPath.row].hotel.rating
        
        if (ratingVal == "1"){
            cell.HotelRating?.text = "*"
        }
        if (ratingVal == "2"){
            cell.HotelRating?.text = "**"
        }
        if (ratingVal == "3"){
            cell.HotelRating?.text = "***"
        }
        if (ratingVal == "4"){
            cell.HotelRating?.text = "****"
        }
        if (ratingVal == "5"){
            cell.HotelRating?.text = "*****"
        }
        
        
        
        //cell.HotelRating?.text
        
        let cityName = (self.arrData[indexPath.row].hotel.address.cityName)
        let countryCode = (self.arrData[indexPath.row].hotel.address.countryCode)
        
        
        cell.HotelAddress?.text = "\(cityName) \(countryCode)"
        
        if (self.arrData[indexPath.row].arrOffers[0].price.total.isEmpty)
        {
            cell.HotelFare?.text = self.arrData[indexPath.row].arrOffers[0].price.base
        }
        else{
            cell.HotelFare?.text = self.arrData[indexPath.row].arrOffers[0].price.total
        }
        return cell
}
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
            self.performSegue(withIdentifier: "gotoroom", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoroom"){
            var upcoming: SelectedRoomViewController = segue.destination
                as! SelectedRoomViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            print("indexPath- \(indexPath)")
            
            let hotelIdtoSend = self.arrData[indexPath.row].hotel.hotelId
            upcoming.hotelId = hotelIdtoSend as! String
         
            let selfurl = self.arrData[indexPath.row].selfurl
            upcoming.nextroomurl = selfurl as! String
            
            var price = ""
            
            if (self.arrData[indexPath.row].arrOffers[0].price.total.isEmpty)
            {
                price = self.arrData[indexPath.row].arrOffers[0].price.base
            }
            else{
                price = self.arrData[indexPath.row].arrOffers[0].price.total
            }
            
            upcoming.approxPrice = price as! String
            
            
            let accessTokentoSend = self.AccessToken
            upcoming.accessToken = accessTokentoSend as! String
            
        }
    }
    
}
