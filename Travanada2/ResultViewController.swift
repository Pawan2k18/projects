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
    @IBOutlet weak var tableView: UITableView!

   var arrData = [DictData]()
    
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
    
    var mysourceData = ""
    var mydestData = ""
    var myAdultData = ""
    var myChildData = ""
    var myInfantData = ""
    var myDateData = ""
    var myTickettypeData = ""
    
    var finalmySource = ""
    var finalmyDest = ""
    var finalmyAdultData = ""
    var finalmyChildData = ""
    var finalmyInfantData = ""
    var finalmyDate = ""
    var finalmyTickettype = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.mysourceData = mySource
        self.mydestData = myDest
        self.myAdultData = myAdult
        self.myChildData = myChild
        self.myInfantData = myInfant
        self.myDateData = myDate
        self.myTickettypeData = myTickettype
        
        self.subStringData()
        self.readJson()
        self.postRequest()
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
            "client_id":"RTG7WqGGp5UfojvlJwWSAf51qGNxPObO",
            "client_secret":"qTsQswCXS8HWQbcx",
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

//       let url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=MAD&destination=PAR&departureDate=2019-08-05&max=5"

        
     print("finalmyInfantData2\(finalmyInfantData)")
     let finalmyAdultData2:Int? = Int(finalmyAdultData) ?? 1
     let finalmyChildData2:Int? = Int(finalmyChildData) ?? 0
     let finalmyInfantData2:Int? = Int(finalmyInfantData) ?? 0
        
        
      let url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=\(finalmySource)&destination=\(finalmyDest)&departureDate=\(finalmyDate)&adults=\(finalmyAdultData2!)&children=\(finalmyChildData2!)&infants=\(finalmyInfantData2!)&travelClass=\(finalmyTickettype)&max=50"

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
                   
                    let resJSON = JSON(response.result.value!)
                    
                    for dictData in resJSON["data"].arrayValue {
                        
                        let data = DictData()
                        data.setdata(dictJson: dictData.dictionaryValue)
                        self.arrData.append(data)
                    }
                    
                    OperationQueue.main.addOperation({
                        self.tableView.reloadData()
                    })
                    
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
    
}


//// MARK : - showing data in tableview

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return arrData.count
}

    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
    
    cell.labelDepartureAirport?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.iataCode

    //let lastElement = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.endIndex
    
    //print("last elements- \(lastElement)")
    
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
    
    let arrdate = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.arrival.at
    let arrdate2 = arrdate.index(arrdate.startIndex, offsetBy: 18)
    let arrdate3 = String(arrdate[...depdate2])
    
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
    
    cell.labelTotalFare?.text = ((dollarSign) + (self.arrData[indexPath.row].arrOffers[0].price.total))
    
    let stoppage = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments.count-1
    
    print("stoppage- \(stoppage)")
    
    if(stoppage != 0){
        cell.label2?.text = "\(stoppage) Stop"
    }
    else{
        cell.label2?.text = "Non-Stop"
    }
    

    //cell.label2?.text = finalmyTickettype

    
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
    // This function is called before the segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let SelectedRowViewController = segue.destination as! SelectedRowViewController
        
        // set a variable in the second view controller with the data to pass
        SelectedRowViewController.lbl1 = "This is your details view page where u can see all your flight details"
        SelectedRowViewController.lbl2 = "after viewing all the details you can book from here."
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("u have selected- \(indexPath.row)")
        
//        let selectedRow:SelectedRowViewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectedRowViewController") as! SelectedRowViewController
//
//        selectedRow.lbl1 = "HELLO" as! String
//        selectedRow.lbl2 = "HI" as! String
//
//        self.navigationController?.pushViewController(selectedRow, animated: true)
        
        // method to run when table view cell is tapped
     
            // Segue to the second view controller
            self.performSegue(withIdentifier: "selectsegue", sender: self)
        }
        
}

