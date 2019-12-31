//
//  CustomTestingClass.swift
//  Travanada2
//
//  Created by Pawan Dey on 27/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import SearchTextField


class CustomTestingClass: UIViewController, CalendarCallBack {

    let home = HomeViewController()
    
    @IBOutlet weak var mainView: ANCustomView!
    @IBOutlet weak var SubView: UIView!
    @IBOutlet weak var JDateView: ANCustomView!
    @IBOutlet weak var RDateView: ANCustomView!
    @IBOutlet weak var date1: UIButton!
    @IBOutlet weak var date2: UIButton!
    @IBOutlet weak var journeyDay: UIButton!
    @IBOutlet weak var returnDay: UIButton!
    @IBOutlet weak var countryTextField: SearchTextField!
    @IBOutlet weak var destinationSearch: SearchTextField!
    
    var selectedDate = Date()
    var tripSelectionVal = ""
    var tagLabel:Int = 0
    var counter = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        
        // getting current date
        let today = NSDate()
        // adding 3 days to current date
        let currentDateplus3Days = NSDate(timeIntervalSinceNow: 86400 * 3)
        let currentDateplus5Days = NSDate(timeIntervalSinceNow: 86400 * 5)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var dateset1 = (dateFormatter.string(from: currentDateplus3Days as Date))
        var dateset2 = (dateFormatter.string(from: currentDateplus5Days as Date))
        
        date1.setTitle(dateset1, for: .normal)
        date2.setTitle(dateset2, for: .normal)
        
        
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Rectangle-4")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        configureSimpleSearchTextField()
        searchTextfieldStyle()
        tripSelectionVal = "One Way"
    }
    
    @objc func back(sender: UIBarButtonItem) {
        
        print("pressed back button not via segue")
        // Perform your custom actions
        
        //StructOperation.glovalVariable.userName = "fromBack"
        
        // Go back to the previous ViewController
        _ = navigationController?.popViewController(animated: true)
    }
   
    
    
    func searchTextfieldStyle(){
    countryTextField.theme.fontColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0) /* #1e1e1e */
    countryTextField.theme = SearchTextFieldTheme.lightTheme()
    countryTextField.theme.font = UIFont.systemFont(ofSize: 10)
    countryTextField.theme.bgColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
    countryTextField.theme.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
    countryTextField.theme.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
    countryTextField.theme.cellHeight = 40
    
    
    destinationSearch.theme.fontColor = UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 1.0) /* #1e1e1e */
    destinationSearch.theme = SearchTextFieldTheme.lightTheme()
    destinationSearch.theme.font = UIFont.systemFont(ofSize: 10)
    destinationSearch.theme.bgColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0) /* #ffffff */
    destinationSearch.theme.borderColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
    destinationSearch.theme.separatorColor = UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0) /* #e5e5e5 */
    destinationSearch.theme.cellHeight = 40
    
        
        countryTextField.leftViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let image = UIImage(named: "flight-d")
        imageView.image = image
        countryTextField.leftView = imageView
        
        destinationSearch.leftViewMode = UITextFieldViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 20, y: 20, width: 20, height: 20))
        let image2 = UIImage(named: "flight-d")
        imageView2.image = image2
        destinationSearch.leftView = imageView2

    }
    
    
    
    // 1 - Configure a simple search text view
    fileprivate func configureSimpleSearchTextField() {
        countryTextField.startVisibleWithoutInteraction = false
        destinationSearch.startVisibleWithoutInteraction = false
        
        // Set data source
        let countries = localCountries()
        countryTextField.filterStrings(countries)
        destinationSearch.filterStrings(countries)
    }
    
    
    // Hide keyboard when touching the screen
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    
    
    // Data Sources
    fileprivate func localCountries() -> [String] {
        if let path = Bundle.main.path(forResource: "airport", ofType: "txt") {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .dataReadingMapped)
                let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as! [[String:String]]
                
                var countryNames = [String]()
                for country in jsonResult {
                    let first = country["IATAcode"]! + ", " + country["Airport"]! + ", " + country["CountryCode"]!
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
    
    
    @IBAction func searchTap(_ sender: UIButton) {
        
        print("first done")
        let CalendarViewController = self.storyboard?.instantiateViewController(withIdentifier: "CalendarViewController") as! CalendarViewController
        CalendarViewController.modalPresentationStyle = .overCurrentContext
        CalendarViewController.delegate = self
        CalendarViewController.selectedDate = selectedDate
        self.present(CalendarViewController, animated: false, completion: nil)
        
        tagLabel = sender.tag
    }
    
    
    
    func didSelectDate(date: Date) {
        selectedDate = date
        
        if (tagLabel == 0){
            date1.setTitle((date.getTitleDateFC()),for: .normal)
            journeyDay.setTitle((date.getTitleDay()),for: .normal)
        }
        else if (tagLabel == 1){
            date2.setTitle((date.getTitleDateFC()),for: .normal)
            returnDay.setTitle((date.getTitleDay()),for: .normal)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let customToDetail = segue.destination as! DetailsViewController
//        customToDetail.originVal = countryTextField.text!
//        customToDetail.destinationVal = destinationSearch.text!
//        customToDetail.journeyDate = date1.currentTitle!
//        customToDetail.returnDate = date2.currentTitle!
//        customToDetail.journeyDay = journeyDay.currentTitle!
//        customToDetail.returnDay = returnDay.currentTitle!
//        customToDetail.tripType = tripSelectionVal
//        customToDetail.counter = true
    }
    
    
    
    @IBAction func DoneBtn(_ sender: Any) {
        print("Done Button Pressed")
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        print("Close Button Pressed")
        //self.dismiss(animated: true, completion: nil)
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func customSegmentedValueChanged(_ sender: CustomSegmentedControl) {
        
        switch sender.selectedSegmentedIndex {
            
        case 0:
            self.tripSelectionVal = "One Way"
            print("One Way")
            UIView.animate(withDuration: 0.3, animations: {
                self.JDateView.center.x = self.SubView.center.x
                self.RDateView.isHidden = true
            })
            
        case 1:
            self.tripSelectionVal = "Round Trip"
            print("Round Trip")
            UIView.animate(withDuration: 0.3, animations: {
                self.RDateView.isHidden = false
                self.JDateView.center.x = self.SubView.center.x - 60
                self.RDateView.center.x = self.SubView.center.x + 60
            })
            
        default:
            self.tripSelectionVal = "One Way"
            self.JDateView.center.x = self.SubView.center.x
            RDateView.isHidden = true
        }
    }
    
    
}
