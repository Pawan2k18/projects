//
//  ResultViewController.swift
//  Travanada2
//
//  Created by MAC-186 on 4/12/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ResultViewController: UIViewController {
    
    let dollarSign = "\u{24}"
    let euroSign = "\u{20AC}"
    @IBOutlet weak var tableView: UITableView!

     let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
   var arrData = [DictData]()
    var meta = Meta()
    var AccessToken:String = ""
    var imageURL = ""
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
   
    var mySource =  ""
    var myDest = ""
    var myAdult = ""
    var myChild = ""
    var myInfant = ""
    var myDate = ""
    var myTickettype = ""
    var myDate2 = ""
    var mytripType = ""
    
    var mysourceData = ""
    var mydestData = ""
    var myAdultData = ""
    var myChildData = ""
    var myInfantData = ""
    var myDateData = ""
    var myTickettypeData = ""
    var myDate2Data = ""
    var mytripTypeData = ""
    
    
    var finalmySource = ""
    var finalmyDest = ""
    var finalmyAdultData = ""
    var finalmyChildData = ""
    var finalmyInfantData = ""
    var finalmyDate = ""
    var finalmyTickettype = ""
    var finalmyDate2 = ""
    var finalmytripType = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
//        self.oneWayView.layer.cornerRadius = 10
//        self.oneWayView.layer.shadowColor = UIColor.lightGray.cgColor
//        self.oneWayView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
//        self.oneWayView.layer.shadowRadius = 10.0
//        self.oneWayView.layer.shadowOpacity = 0.7
//        
//        self.roundtripView.layer.cornerRadius = 10
//        self.roundtripView.layer.shadowColor = UIColor.lightGray.cgColor
//        self.roundtripView.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
//        self.roundtripView.layer.shadowRadius = 10.0
//        self.roundtripView.layer.shadowOpacity = 0.7
//        
        
        //self.title = "\(StructOperation.flightDetails.from) - \(StructOperation.flightDetails.to)"
       
        //let barButton = UIBarButtonItem(customView: activityIndicator)
        //self.navigationItem.setRightBarButton(barButton, animated: true)
        //activityIndicator.startAnimating()
        
        
//        view.addSubview(activityIndicator) // add it as a  subview
//        activityIndicator.center = CGPoint(x: view.frame.size.width*0.5, y: view.frame.size.height*0.5)
//        activityIndicator.startAnimating()
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.transform = transform
        activityIndicator.center = self.view.center
        activityIndicator.startAnimating()
        self.view.addSubview(activityIndicator)
        
        
        
        self.mysourceData = mySource
        self.mydestData = myDest
        self.myAdultData = myAdult
        self.myChildData = myChild
        self.myInfantData = myInfant
        self.myDateData = myDate
        self.myTickettypeData = myTickettype
        self.myDate2Data = myDate2
        self.mytripTypeData = mytripType
        
        
        self.subStringData()
        self.readJson()
        self.postRequest()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        
            let firstLabel = UILabel(frame: CGRect(x: 10, y: 0, width: 50, height: 40))
            firstLabel.numberOfLines = 2
            firstLabel.textAlignment = .center
            firstLabel.font = UIFont.boldSystemFont(ofSize: 14.0)
            firstLabel.textColor = UIColor.white
            firstLabel.sizeToFit()
        
        if (mytripType == "One Way"){
            firstLabel.text = "\(StructOperation.flightDetails.from.prefix(3)) - \(StructOperation.flightDetails.to.prefix(3))\n\(StructOperation.flightDetails.departDate)"
            self.navigationItem.titleView = firstLabel
        }
            
        else if (mytripType == "Round Trip"){
            firstLabel.text = "\(StructOperation.flightDetails.from.prefix(3)) - \(StructOperation.flightDetails.to.prefix(3))\n\(StructOperation.flightDetails.departDate) - \(StructOperation.flightDetails.returnDate)"
            self.navigationItem.titleView = firstLabel
        }
    
    }
    
    
    @IBAction func backToHome(_ sender: Any) {
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(listVc, animated: true)
    }
    
    
    func subStringData(){
        var index = mysourceData.index(mysourceData.startIndex, offsetBy: 3)
        finalmySource = String(mysourceData[..<index])
        print("finalmySource- \(finalmySource)")
        
        var index2 = mydestData.index(mydestData.startIndex, offsetBy: 3)
        finalmyDest = String(mydestData[..<index2])
        print("finalmyDest- \(finalmyDest)")
        
        finalmyAdultData = myAdultData
        print("finalmyAdultData- \(finalmyAdultData)")

        finalmyChildData = myChildData
        print("finalmyChildData- \(finalmyChildData)")
        
        finalmyInfantData = myInfantData
        print("finalmyInfantData- \(finalmyInfantData)")
        
        finalmyDate = myDateData
        print("finalmyDate- \(finalmyDate)")
        
        finalmyTickettype = myTickettypeData
        print("finalmyTickettype- \(finalmyTickettype)")
        
        finalmyDate2 = myDate2Data
        print("finalmyDate2- \(finalmyDate2)")
        
        finalmytripType = mytripTypeData
        print("finalmytripType- \(finalmytripType)")
        
    }
    
    
    // MARK : - reading airport deatils from local assets folder
    func readJson() {
        do {
            if let file = Bundle.main.url(forResource: "airport", withExtension: "txt") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
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
    

    // MARK : - Get request for receiving response from server and parsing data
    
    func getData(accessToken:String) {
        
        print("bbbb-\(mySource)")
        
        var responseReturn:Any?
        
//        let url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=\(finalmySource)&destination=\(finalmyDest)&departureDate=\(finalmyDate)&max=50"

 //      let url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=MAD&destination=PAR&departureDate=2019-08-05&max=5"

        
     print("finalmyInfantData2\(finalmyInfantData)")
     let finalmyAdultData2:Int? = Int(finalmyAdultData) ?? 1
     let finalmyChildData2:Int? = Int(finalmyChildData) ?? 0
     let finalmyInfantData2:Int? = Int(finalmyInfantData) ?? 0
        
        var url2 = ""
        var tripType = ""
        
        if (finalmytripType == "One Way"){
            
      url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=\(finalmySource)&destination=\(finalmyDest)&departureDate=\(finalmyDate)&adults=\(finalmyAdultData2!)&children=\(finalmyChildData2!)&travelClass=\(finalmyTickettype.uppercased() )&max=10"

        }
            
        else{
            
          url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=\(finalmySource)&destination=\(finalmyDest)&departureDate=\(finalmyDate)&returnDate=\(finalmyDate2)&adults=\(finalmyAdultData2!)&children=\(finalmyChildData2!)&travelClass=\(finalmyTickettype.uppercased() )&max=10"
        }
        
        print("urll-\(url2)")
        
        
        let headers2 : HTTPHeaders = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer \(accessToken)"
        ]
        
        Alamofire.request(url2, method: .get,encoding:JSONEncoding.default,headers: headers2).responseJSON{
            (response) -> Void in
            
//            if let metacurrency =  as? [String: AnyObject] {
//                print(value)
//            }
//
//
            
            if response.result.isSuccess {
                
                self.activityIndicator.stopAnimating()
                let resJSON = JSON(response.result.value!)
           
                var dictCount = resJSON["data"].count
                if(dictCount != 0)
                {
                        for dictData in resJSON["data"].arrayValue {
                            let data = DictData()
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


//// MARK : - showing data in tableview

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return arrData.count
}

    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    if (finalmytripType == "One Way"){
        
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell

    
    cell.labelDepartureAirport?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.iataCode

    //let lastElement = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.endIndex
    
    // print("last elements- \(lastElement)")
    
    cell.labelArrivalAirport?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.arrival.iataCode

    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    let dateFormatterPrint = DateFormatter()
    dateFormatterPrint.dateFormat = "HH:mm"
    
    let dateFormatterPrint2 = DateFormatter()
    dateFormatterPrint2.dateFormat = "MMM dd"
    
    // converting departure date to Hours and mins
    var finaldepdate = ""
    let depdate = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.at
    
    let depdate2 = depdate.index(depdate.startIndex, offsetBy: 18)
    let depdate3 = String(depdate[...depdate2])
    
    if let date = dateFormatterGet.date(from: depdate3) {
        finaldepdate = (dateFormatterPrint.string(from: date))
        print(finaldepdate)
    } else {
        print("There was an error decoding the string")
    }
     cell.labelDepartureTime?.text = finaldepdate
    
    
    
     // converting arrival date to Hours and mins
    var finalarrdate = ""
    
    let arrdate = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.arrival.at
    let arrdate2 = arrdate!.index(arrdate!.startIndex, offsetBy: 18)
    let arrdate3 = String(arrdate![...depdate2])
    
    if let date = dateFormatterGet.date(from: arrdate3) {
        finalarrdate = (dateFormatterPrint.string(from: date))
        print(finalarrdate)
    } else {
        print("There was an error decoding the string")
    }
    cell.labelArrivalTime?.text = finalarrdate

    
    
    // formatting total time value from 0DT2H20M to 2 h 20 m
    let aString = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.duration
    
    var newString3 = ""
    let finalString = aString![aString!.index(aString!.startIndex, offsetBy: 0)]
    print("finalString \(finalString)")
    
    if (finalString == "0"){
        let newString = aString!.replacingOccurrences(of: "H", with: " h ", options: .literal, range: nil)
        let newString2 = newString.replacingOccurrences(of: "M", with: " m", options: .literal, range: nil)
        newString3 = newString2.replacingOccurrences(of: "0DT", with: "", options: .literal, range: nil)
        print("newString3 \(newString3)")
    }
    else {
        let newString = aString!.replacingOccurrences(of: "H", with: " h ", options: .literal, range: nil)
        let newString2 = newString.replacingOccurrences(of: "M", with: " m", options: .literal, range: nil)
        newString3 = newString2.replacingOccurrences(of: "DT", with: " d ", options: .literal, range: nil)
       print("newString3 \(newString3)")
    }
    
    cell.labelTotalTime?.text = newString3
    
    //var currencyType = self.arrData[indexPath.row]
        
    var labelTotalFareString = self.arrData[indexPath.row].arrOffers[0].price.total
    let labelTotalFareDouble = (labelTotalFareString as NSString).doubleValue
        
    var labelTotalFareRound = Int(ceil(labelTotalFareDouble))
        
    cell.labelTotalFare?.text = "\(self.euroSign) \(labelTotalFareRound)"
    
    let stoppage = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.count-1
    
    print("stoppage- \(stoppage)")
    
    if(stoppage != 0){
        cell.label2?.text = "\(stoppage) Stop"
    }
    else{
        cell.label2?.text = "Non-Stop"
    }
    
    // for dep date under imageview
    
    var finaldepdateLbl = ""
    let depdateLbl = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.at
    
    let depdateLbl2 = depdateLbl.index(depdateLbl.startIndex, offsetBy: 18)
    let depdateLbl3 = String(depdateLbl[...depdateLbl2])
    
    if let date = dateFormatterGet.date(from: depdateLbl3) {
        finaldepdateLbl = (dateFormatterPrint2.string(from: date))
        print(finaldepdateLbl)
    } else {
        print("There was an error decoding the string")
    }
   
    let flightCodeNum = (self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode) + " " + (self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.number)
    
    cell.labelDate?.text = flightCodeNum

    imageURL="http://www.gstatic.com/flights/airline_logos/70px/\(self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode).png";
        print(imageURL)

    let url = URL(string: imageURL)!
    cell.imgViewLogo.af_setImage(withURL: url)
return cell
    }
    
    
    
    
        // MARK: Setting data fot roundtrip
    else{
        
        // Setting data fot roundtrip in inbound
        let cell = tableView.dequeueReusableCell(withIdentifier: "roundtripcell") as! TableViewCell2
        
        
        cell.labelDepartureAirport1?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.iataCode
        
        //let lastElement = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.endIndex
        
        print("indexPath.row- \(indexPath.row)")
        
        cell.labelArrivalAirport1?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.arrival.iataCode
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "HH:mm"
        
        let dateFormatterPrint2 = DateFormatter()
        dateFormatterPrint2.dateFormat = "MMM dd"
        
        // converting departure date to Hours and mins
        var finaldepdate = ""
        let depdate = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.at
        
        let depdate2 = depdate.index(depdate.startIndex, offsetBy: 18)
        let depdate3 = String(depdate[...depdate2])
        
        if let date = dateFormatterGet.date(from: depdate3) {
            finaldepdate = (dateFormatterPrint.string(from: date))
            print(finaldepdate)
        } else {
            print("There was an error decoding the string")
        }
        cell.labelDepartureTime1?.text = finaldepdate
        
        
        
        // converting arrival date to Hours and mins
        var finalarrdate = ""
        
        let arrdate = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.arrival.at
        let arrdate2 = arrdate!.index(arrdate!.startIndex, offsetBy: 18)
        let arrdate3 = String(arrdate![...arrdate2])
        
        if let date = dateFormatterGet.date(from: arrdate3) {
            finalarrdate = (dateFormatterPrint.string(from: date))
            print(finalarrdate)
        } else {
            print("There was an error decoding the string")
        }
        cell.labelArrivalTime1?.text = finalarrdate
        
        
        
        // formatting total time value from 0DT2H20M to 2 h 20 m
        let aString = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.last?.flightSegment.duration
        
        var newString3 = ""
        let finalString = aString![aString!.index(aString!.startIndex, offsetBy: 0)]
        print("finalString \(finalString)")
        
        if (finalString == "0"){
            let newString = aString!.replacingOccurrences(of: "H", with: " h ", options: .literal, range: nil)
            let newString2 = newString.replacingOccurrences(of: "M", with: " m", options: .literal, range: nil)
            newString3 = newString2.replacingOccurrences(of: "0DT", with: "", options: .literal, range: nil)
            print("newString3 \(newString3)")
        }
        else {
            let newString = aString!.replacingOccurrences(of: "H", with: " h ", options: .literal, range: nil)
            let newString2 = newString.replacingOccurrences(of: "M", with: " m", options: .literal, range: nil)
            newString3 = newString2.replacingOccurrences(of: "DT", with: " d ", options: .literal, range: nil)
            print("newString3 \(newString3)")
        }
        
        cell.labelTotalTime1?.text = newString3
        
        var labelTotalFareString = self.arrData[indexPath.row].arrOffers[0].price.total
        let labelTotalFareDouble = (labelTotalFareString as NSString).doubleValue
        
        var labelTotalFareRound = Int(ceil(labelTotalFareDouble))
        
        cell.labelTotalFare1?.text = "\(self.euroSign) \(labelTotalFareRound)"

        
        let stoppage = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.count-1
        
        print("stoppage- \(stoppage)")
        
        if(stoppage != 0){
            cell.stoppage1?.text = "\(stoppage) Stop"
        }
        else{
            cell.stoppage1?.text = "Non-Stop"
        }
        
        // for dep date under imageview
        
        var finaldepdateLbl = ""
        let depdateLbl = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.at
        
        let depdateLbl2 = depdateLbl.index(depdateLbl.startIndex, offsetBy: 18)
        let depdateLbl3 = String(depdateLbl[...depdateLbl2])
        
        if let date = dateFormatterGet.date(from: depdateLbl3) {
            finaldepdateLbl = (dateFormatterPrint2.string(from: date))
            print(finaldepdateLbl)
        } else {
            print("There was an error decoding the string")
        }
        
        let flightCodeNum = (self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode) + " " + (self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.number)
        
        cell.FlightCodeNubmer1?.text = flightCodeNum
        
        imageURL="http://www.gstatic.com/flights/airline_logos/70px/\(self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode).png";
        print(imageURL)
        
        let url = URL(string: imageURL)!
        cell.imgViewLogo1.af_setImage(withURL: url)
        
        
 //////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        // Setting data fot roundtrip in Outbound
        
        cell.labelDepartureAirport2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.departure.iataCode
        
        cell.labelArrivalAirport2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments.last?.flightSegment.arrival.iataCode

        cell.labelDepartureTime2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.departure.at
        
        cell.labelArrivalTime2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.arrival.at
        
        cell.labelTotalTime2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments.last?.flightSegment.duration
    
        
        let stoppage2 = self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments.count-1
        
        print("stoppage2- \(stoppage2)")
        
        if(stoppage2 != 0){
            cell.stoppage2?.text = "\(stoppage2) Stop"
        }
        else{
            cell.stoppage2?.text = "Non-Stop"
        }
        
        let flightCodeNum2 = (self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.carrierCode) + " " + (self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.number)
        
        cell.FlightCodeNubmer1?.text = flightCodeNum2
        
        var imageURL2="http://www.gstatic.com/flights/airline_logos/70px/\(self.arrData[indexPath.row].arrOffers[0].arrservices[1].arrsegments[0].flightSegment.carrierCode).png";
        print(imageURL2)
        
        let url4 = URL(string: imageURL2)!
        cell.imgViewLogo2.af_setImage(withURL: url4)
        
        
        return cell
    }
    
}

//    //let status = statuses[indexPath.row]
//    cell.HotelName?.text = self.arrData.hotel2.name
//    cell.HotelAddress?.text = (self.arrData.hotel2.address.cityName) + (self.arrData.hotel2.address.countryCode)
//    cell.HotelRating?.text = self.arrData.hotel2.rating
//    cell.HotelDistance?.text = self.arrData.hotel2.address.postalCode
//    cell.HotelCity?.text = self.arrData.hotel2.address.cityName
//
//
//    let section = ["Detail", "Room Images", "Description", "Faclities", "Select Room Type"]
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "selectData")
        {
           
            var upcoming: SelectedRowViewController = segue.destination
                as! SelectedRowViewController
        
            let indexPath = self.tableView.indexPathForSelectedRow!
            print("indexPath- \(indexPath)")

            let titleString = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments
            print("titleString- \(titleString)")
            upcoming.titleStringViaSegue = titleString as! [DictSegments]
            
            var labelTotalFareString = self.arrData[indexPath.row].arrOffers[0].price.total
            let labelTotalFareDouble = (labelTotalFareString as NSString).doubleValue
            
            var labelTotalFareRound = Int(ceil(labelTotalFareDouble))
            
            
            //let totalFare = Int(ceil(self.arrData[indexPath.row].arrOffers[0].price.total))
            upcoming.totalFareVal = labelTotalFareRound
            
            upcoming.isOneOrRound = "onewayselected"
            
            let uniqueId = self.arrData[indexPath.row].id
            upcoming.uniqueId = uniqueId as! String
            
    
            
            
            //self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
        
        else if (segue.identifier == "selectData2")
        {
            
            var upcoming: SelectedRowViewController = segue.destination
                as! SelectedRowViewController
            
            let indexPath = self.tableView.indexPathForSelectedRow!
            print("indexPath- \(indexPath)")
            
            let titleString = self.arrData[indexPath.row].arrOffers[0].arrservices
            print("titleString- \(titleString)")
            upcoming.titleStringViaSegue2 = titleString as! [DictServices]
            
            let titleString2 = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments
            print("titleString2- \(titleString2)")
            upcoming.titleStringViaSegue3 = titleString2 as! [DictSegments]
            
            var labelTotalFareString = self.arrData[indexPath.row].arrOffers[0].price.total
            let labelTotalFareDouble = (labelTotalFareString as NSString).doubleValue
            
            var labelTotalFareRound = Int(ceil(labelTotalFareDouble))
            
            //let totalFare = Int(ceil(self.arrData[indexPath.row].arrOffers[0].price.total))
            upcoming.totalFareVal = labelTotalFareRound
            
            let uniqueId = self.arrData[indexPath.row].id
            upcoming.uniqueId = uniqueId as! String
            upcoming.isOneOrRound = "roundwayselected"
            
            
            //self.tableView.deselectRow(at: indexPath, animated: true)
        }
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if (finalmytripType == "One Way"){
            self.performSegue(withIdentifier: "selectData", sender: self)
        }
        else
        {
            self.performSegue(withIdentifier: "selectData2", sender: self)
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if (finalmytripType == "One Way"){
            return 154.0
        }
        else{
            return 300.0
        }
        
    }
    
}

