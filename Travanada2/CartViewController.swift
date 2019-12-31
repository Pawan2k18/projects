//
//  CartViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import RealmSwift

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bookAllBtn: KButton!
    
   var totalfare:Double = 0.0
    
    var hotels :  Results<HotelData>!
    var flights :  Results<FlightData>!
    
    var section = ["FlightData","hotelData"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let delBtn = UIBarButtonItem(image: UIImage(named: ""), style: .plain, target: self, action: Selector("action")) // action:#selector(Class.MethodName) for swift 3
//        self.navigationItem.rightBarButtonItem  = delBtn
        
        var backbutton = UIButton(type: .custom)
        backbutton.setImage(UIImage(named: "back-icon"), for: .normal) // Image can be downloaded from here below link
        backbutton.setTitleColor(backbutton.tintColor, for: .normal)
        backbutton.addTarget(self, action: #selector(self.backAction(_:)), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
        

        //print("hotels- \(hotels)")
        //print("flights- \(flights)")
        
        tableView.register(UINib(nibName: "FlightTableViewCell", bundle: nil), forCellReuseIdentifier: "FlightTableViewCell")
        tableView.register(UINib(nibName: "HotelTableViewCell", bundle: nil), forCellReuseIdentifier: "HotelTableViewCell")
        
        getRealm { (realm) in
            self.hotels = realm.objects(HotelData.self)
            self.flights = realm.objects(FlightData.self)
        }
   
        print(hotels)
        print(flights)
        
        self.tableView.reloadData()
    }
    
    
    
    @objc func backAction(_ sender: Any){
        print("preddeded")
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //self.totalPrice.text = String(self.totalfare)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let totalFareRound = Double(round(100*self.totalfare)/100)
        print("totalFareRound- \(totalFareRound)")  // 299.96
        
        
        self.totalPrice.text = String(totalFareRound)
        if tableView.visibleCells.count == 0 {
//            // tableView is empty. You can set a backgroundView for it.
//            let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
//            label.text = "No Data Available !!"
//            label.textColor = UIColor.black;
//            label.textAlignment = .center
//            label.sizeToFit()
//            tableView.backgroundView = label;
//            tableView.separatorStyle = .none;
            
            
            let imageName = "emptycart.png"
            let image = UIImage(named: imageName)
            let imageView = UIImageView(image: image!)
            
            imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 300)
            imageView.contentMode = .scaleAspectFit
            
            imageView.center = CGPoint(x: view.frame.size.width  / 2,
                                         y: view.frame.size.height / 2)
            view.addSubview(imageView)
            tableView.separatorStyle = .none;
            
            bookAllBtn.isHidden = true
           
        }
        
        
    }
    

    
    @IBAction func goBack(_ sender: Any) {
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(listVc, animated: true)
    }
    
    
    
    @IBAction func bookAllBtn(_ sender: Any) {
        
        
        print("booking done")
      
        let realm = try! Realm()
        let flightsall = realm.objects(FlightData.self)
        let hotelsall = realm.objects(HotelData.self)
        print(flightsall)
        print(hotelsall)
        
        
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "InitialViewController") as! InitialViewController
        
            //secondVC.totalFare = self.totalfare
        StructOperation.TotalFareForPayment.totalFare = self.totalfare
        self.navigationController?.pushViewController(secondVC, animated: true)
        
        
    }
    
    
    
    
    @IBAction func delAll(_ sender: Any) {
       
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
        
        self.totalPrice.text = "0.0"
        self.tableView.reloadData()
    }
    
 
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if self.section.count == 0 {
            self.tableView.setEmptyView(title: "You don't have any contact.", message: "Your Items will be in here.")
        }
        else {
            tableView.restore()
        }
        return self.section.count
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0:
            if(flights.count >= 1)
            {
                return "FlightData"
            }
            else {
                return nil
                }
            
        default :
            if(hotels.count >= 1)
            {
                return "HotelData"
            }
            else {
                return nil
            }
        
            //return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0 : return 137
        default : return 101
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0 : return flights.count
        default :  return hotels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section{
            
        case 0: let cell = self.tableView.dequeueReusableCell(withIdentifier: "FlightTableViewCell") as! FlightTableViewCell
        
        
            
        cell.from?.text = flights[indexPath.row].from
        cell.to?.text = flights[indexPath.row].to
        cell.deptime?.text = flights[indexPath.row].jdate
        cell.arrtime?.text = flights[indexPath.row].rdate
        var fare = Double(flights[indexPath.row].flightFare)
        self.totalfare =  self.totalfare + (fare ??  0.0)
        
        cell.totalfare?.text = flights[indexPath.row].flightFare
        cell.flightType.text = (flights[indexPath.row].flightType=="onewayselected" ? "One way" : "Round trip")
        
        return cell
        
        default: let myCell = self.tableView.dequeueReusableCell(withIdentifier: "HotelTableViewCell") as! HotelTableViewCell

     
        //var fare = Double(hotels[indexPath.row].hotelfare)
        myCell.hotelName?.text = hotels[indexPath.row].hotelname
        myCell.hotelAddress?.text = hotels[indexPath.row].location
        myCell.checkin?.text = hotels[indexPath.row].checkin
        myCell.checkout?.text = hotels[indexPath.row].checkout
        myCell.totalFare?.text = hotels[indexPath.row].hotelfare
        
        var fare2 = Double(hotels[indexPath.row].hotelfare)
        
        self.totalfare =  self.totalfare + (fare2 ?? 0.0)
        return myCell
        }
    
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            if let item = flights?[indexPath.row] {
                let realm = try! Realm()
                try! realm.write {
                    realm.delete(item)
                }
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            }
        }
    }
    
    
    
}

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}


extension Object {
    func toDictionary() -> NSDictionary {
        let properties = self.objectSchema.properties.map { $0.name }
        let dictionary = self.dictionaryWithValues(forKeys: properties)
        
        var mutabledic = NSMutableDictionary()
        mutabledic.setValuesForKeys(dictionary)
        
        for prop in self.objectSchema.properties as [Property]! {
            // find lists
            if let objectClassName = prop.objectClassName  {
                if let nestedObject = self[prop.name] as? Object {
                    mutabledic.setValue(nestedObject.toDictionary(), forKey: prop.name)
                } else if let nestedListObject = self[prop.name] as? ListBase {
                    var objects = [AnyObject]()
                    for index in 0..<nestedListObject._rlmArray.count  {
                        if let object = nestedListObject._rlmArray[index] as? Object {
                            objects.append(object.toDictionary())
                        }
                    }
                    mutabledic.setObject(objects, forKey: prop.name as NSCopying)
                }
            }
        }
        return mutabledic
    }
}






//        switch indexPath.section{
//
//            case 0 : let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//                cell?.textLabel?.text = flights[indexPath.row].from
//                cell?.detailTextLabel?.text = flights[indexPath.row].to
//                return cell ?? UITableViewCell()
//
//        default : let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
//
//            cell?.textLabel?.text = hotels[indexPath.row].location
//            cell?.detailTextLabel?.text = hotels[indexPath.row].checkin
//            return cell ?? UITableViewCell()
//
//        }
        
//    }
//
//
//}
