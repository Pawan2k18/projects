//
//  MainViewController.swift
//  SearchTextField
//

import UIKit
import SearchTextField

class DestinationViewController: UITableViewController {
    
    @IBOutlet weak var countryTextField2: SearchTextField!
    
    
    var countryTextValue2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        tableView.tableFooterView = UIView()
        
        // 1 - Configure a simple search text field
        configureSimpleSearchTextField()
        
    }
    
    
    
    // 1 - Configure a simple search text view
    fileprivate func configureSimpleSearchTextField() {
        // Start visible even without user's interaction as soon as created - Default: false
        countryTextField2.startVisibleWithoutInteraction = false
        
        // Set data source
        let countries = localCountries()
        countryTextField2.filterStrings(countries)
        
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
                    let first = country["IATAcode"]! + ", " + country["CityName"]! + ", " + country["CountryCode"]!
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
    

    
    
    
    @IBAction func doneBtnDestinationTap(_ sender: Any) {
        self.countryTextValue2 = countryTextField2.text!
        performSegue(withIdentifier: "returndestination", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc2 = segue.destination as! HomeViewController
        vc2.finalDestination = self.countryTextValue2
    }
    
    
    @IBAction func cancelBtnTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
