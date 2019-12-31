//
//  SearchViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 18/07/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import SearchTextField
import CoreLocation
import Alamofire
import SwiftyJSON

protocol DataPass{
    func dataPassing(name:String)
}


class SearchViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager:CLLocationManager!
    
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var currentLocBtn: UIView!
    @IBOutlet weak var searchLocation: SearchTextField!
    
    var delegate:DataPass!
    
    var lngval:Double = 0
    var latval:Double = 0
    var Corordinate = ""
    var currentAirport = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

         determineMyCurrentLocation()
        
        configureSimpleSearchTextField()
        searchTextfieldStyle()
        
        let tap3: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(didTapLabelDemo3))
        currentLocBtn.addGestureRecognizer(tap3)
        tap3.delegate = self as? UIGestureRecognizerDelegate
        
        
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // manager.stopUpdatingLocation()
        
        latval = userLocation.coordinate.latitude
        lngval = userLocation.coordinate.longitude
        
        self.Corordinate = "lng=\(lngval)&lat=\(latval)"
        
        print("hhhh222- \(Corordinate)")
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.getCurrentCity(corordinate: self.Corordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    
    func getCurrentCity(corordinate:String){
        
        let url = "https://cometari-airportsfinder-v1.p.rapidapi.com/api/airports/nearest?\(corordinate)"
        
        
        print("hhhh- \(corordinate)")
        
        let headers : HTTPHeaders = [
            "X-RapidAPI-Host": "cometari-airportsfinder-v1.p.rapidapi.com",
            "X-RapidAPI-Key": "80e3ad1422msh70fd682f6efb739p186a45jsn9ff7230d6ea2"
        ]
        
        Alamofire.request(url, method: .get,encoding:JSONEncoding.default,headers: headers).responseJSON{ response in
            
            switch response.result {
                
            case .success(let data):
                let json = JSON(data)
                self.currentAirport = json["code"].stringValue
                print("code is- \(self.currentAirport)")
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    
    
    
    @objc func didTapLabelDemo3(sender: UITapGestureRecognizer)
    {
        print("you tapped view1")
        //determineMyCurrentLocation()
        print("mmm \(self.currentAirport)")
        
        delegate.dataPassing(name: self.currentAirport)
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    func searchTextfieldStyle(){
        searchLocation.theme.fontColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0) /* #1e1e1e */
        searchLocation.theme = SearchTextFieldTheme.lightTheme()
        searchLocation.theme.font = UIFont.systemFont(ofSize: 10)
        searchLocation.theme.bgColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
        searchLocation.theme.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
        searchLocation.theme.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
        searchLocation.theme.cellHeight = 40
        
    }
    
    
    
    // 1 - Configure a simple search text view
    fileprivate func configureSimpleSearchTextField() {
        searchLocation.startVisibleWithoutInteraction = false
        
        // Set data source
        let countries = localCountries()
        searchLocation.filterStrings(countries)
    }
    
    
    // Hide keyboard when touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
//
//    // Data Sources
//    fileprivate func localCountries() -> [String] {
//        if let path = Bundle.main.path(forResource: "airport", ofType: "txt") {
//            do {
//                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
//                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:String]]
//
//                var countryNames = [String]()
//                for country in jsonResult {
//                    let first = country["IATAcode"]! + ", " + country["Airport"]! + ", " + country["CountryCode"]!
//                    countryNames.append(first)
//                }
//
//                return countryNames
//            } catch {
//                print("Error parsing jSON: \(error)")
//                return []
//            }
//        }
//        return []
//    }
    
    
    fileprivate func localCountries() -> [String] {
        if let path = Bundle.main.path(forResource: "airline", ofType: "json") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:String]]
                
                var countryNames = [String]()
                for country in jsonResult {
                    let first = country["code"]! + ", " + country["airline"]!
                    countryNames.append(first)
                }
                
                return countryNames
            } catch {
                print("Error parsing jSON: \(error)")
                return []
            }
        }
        return []
    }
    
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "originsegue"{
//            let customToDetail = segue.destination as! HomeViewController
//            customToDetail.finalSource = searchLocation.text!
//        }
//
//        if segue.identifier == "destisegue"{
//            let customToDetail = segue.destination as! HomeViewController
//            customToDetail.finalDestination = searchLocation.text!
//        }
//
//    }
    
    
//
//    @IBAction func currentAirportTap(_ sender: Any) {
//
//    }
//
    

    
    @IBAction func doneBtnTap(_ sender: Any) {
        delegate.dataPassing(name: searchLocation.text!)

        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
 
}
