//
//  ViewController.swift
//  AlamofireWithSwiftyJSON
//
//  Created by MAC-186 on 4/12/16.
//  Copyright © 2016 Kode. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireImage

class ResultViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let devCousesImages = [UIImage(named: "fli"), UIImage(named: "fli"), UIImage(named: "fli"), UIImage(named: "fli"), UIImage(named: "fli")]
    
    
    var arrData = [DictData]()

    var AccessToken:String = ""
    var imageURL = ""
    var arrRes = [[String:AnyObject]]() //Array of dictionary
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.readJson()
        self.postRequest()
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
        
        var responseReturn:Any?
        let url2 = "https://test.api.amadeus.com/v1/shopping/flight-offers?origin=NYC&destination=PAR&departureDate=2019-07-01&max=50"
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
    
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return arrData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
//
//        print(cell)
//
//        print ("val- \(self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.number)")
//
//        cell.label1?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode
//
//        cell.label2?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.number
//
//        //cell.imageView?.image = UIImage(named: headline.image)
//        //cell.imageView.image = [UIImage named: "fli.png"]
//
//        cell.imgView.image=self.devCousesImages[indexPath .row]
//
//        return cell
//
//    }
//
}


//// MARK : - showing data in tableview

extension ViewController: UITableViewDelegate, UITableViewDataSource{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return arrData.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
    
    print ("val- \(self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.number)")
    
   cell.labelSource?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.iataCode
    
    cell.labelDestination?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.arrival.iataCode

    cell.labelArrival?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.departure.at

    cell.labelDeparture?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.arrival.at

       cell.labelTotalTime?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.duration
    
    cell.labelTotalFare?.text = self.arrData[indexPath.row].arrOffers[0].price.total
    
    cell.label2?.text = self.arrData[indexPath.row].arrOffers[0].pricePerAdult.total
    
    cell.labelDate?.text = self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.aircraft.code

    imageURL="http://www.gstatic.com/flights/airline_logos/70px/\(self.arrData[indexPath.row].arrOffers[0].arrservices[0].arrsegments[0].flightSegment.carrierCode).png";
        print(imageURL)

    let url = URL(string: imageURL)!
    cell.imgViewLogo.af_setImage(withURL: url)

    return cell
    
}
}
