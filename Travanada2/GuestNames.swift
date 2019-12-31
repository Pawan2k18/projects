//
//  GuestNames.swift
//  Travanada2
//
//  Created by Pawan Dey on 11/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class GuestNames: UIViewController {

    let euroSign = "\u{20AC}"
    var firebaseUid = ""
    var firebaseEmail = ""
    
    var totalcount:Int?
    
    @IBOutlet weak var tableView: UITableView!
    
    var newItems = [[String:String]]()
    var dict = [String:String]()
    
    
    @IBOutlet weak var mytitle: DropDown!
    @IBOutlet weak var mysurname: UITextField!
    @IBOutlet weak var myfirstname: UITextField!
    @IBOutlet weak var mycountryTerritory: UITextField!
    @IBOutlet weak var myphoneNum: SDCTextField!
    @IBOutlet weak var myemail: UITextField!
    @IBOutlet weak var mygender: DropDown!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var checkin: UILabel!
    @IBOutlet weak var checkout: UILabel!
    @IBOutlet weak var totalguest: UILabel!
    @IBOutlet weak var hotelFare: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let user = Auth.auth().currentUser
        if let user = user {
            self.firebaseUid = user.uid
            self.firebaseEmail = user.email!
        }
        
        self.myemail.text = firebaseEmail
        
        self.myphoneNum.delegate = self
      
        self.myphoneNum.valueType = .onlyNumbers
    
        self.myphoneNum.maxLength = 10
       
        self.mygender.text = "Male"
         self.mytitle.text = "Mr."
        
        // The list of array to display. Can be changed dynamically
        mytitle.optionArray = ["Mr.", "Mrs.", "Miss"]
        
        // The the Closure returns Selected Index and String
        mytitle.didSelect{(selectedText , index ,id) in
            self.mytitle.text = "\(selectedText)"
        }
        
        // The list of array to display. Can be changed dynamically
        mygender.optionArray = ["Male", "Female"]
        
        // The the Closure returns Selected Index and String
        mygender.didSelect{(selectedText , index ,id) in
            self.mygender.text = "\(selectedText)"
        }
        
        
        self.location?.text = StructOperation.glovalVariable.location
        
        self.checkin?.text = StructOperation.glovalVariable.checkin
        self.checkout?.text = StructOperation.glovalVariable.checkout
        self.totalguest?.text = String("\(StructOperation.glovalVariable.totalroom) \(StructOperation.glovalVariable.totalguest) Guest")
        
        self.hotelFare?.text = "\(self.euroSign) \(StructOperation.glovalVariable.hotelFare)"
        self.totalcount = StructOperation.glovalVariable.totalguest
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib.init(nibName: "GuestDetailCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "GuestDetailCell")
        
        //tableView.register(UINib(nibName: "GuestDetailCell", bundle: nil), forCellReuseIdentifier: "GuestDetailCell")
        
    }
    
    
    func showToast(controller: UIViewController, message : String, seconds: Double){
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.5
        alert.view.layer.cornerRadius = 15
        
        controller.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func submitBtn(_ sender: Any) {
        var validationArray = [String]()
        print("validationArray-\(validationArray)")
        
        var title = ""
        var surname =  ""
        var firstname = ""
        var gender = ""
        var counTer = ""
        var phone = ""
        var email = ""
        
//
//        let title = mytitle.text!
//        let surname = mysurname.text!
//        let firstname = myfirstname.text!
//        let gender = mygender.text!
//        let counTer = mycountryTerritory.text!
//        let phone = myphoneNum.text!
//        let email = myemail.text!
        
        
        if(mytitle.text!.isEmpty || mysurname.text!.isEmpty || myfirstname.text!.isEmpty || mygender.text!.isEmpty || mycountryTerritory.text!.isEmpty || myphoneNum.text!.isEmpty || myemail.text!.isEmpty)
        {
            print("empty String")
            validationArray.append("Empty")
        }
        else {
            
            title = mytitle.text!
            surname = mysurname.text!
            firstname = myfirstname.text!
            gender = mygender.text!
            counTer = mycountryTerritory.text!
            phone = myphoneNum.text!
            email = myemail.text!
            
            
        let dict2 = ["title": "\(title)", "surname": "\(surname)", "firstname": "\(firstname)", "gender": "\(gender)", "counTer": "\(counTer)", "phone": "\(phone)", "email": "\(email)"]
        
        self.newItems.append(dict2)
        }
        
        
        
        for totrows in 0 ..< self.totalcount! - 1 {
            
            let index = IndexPath(row: totrows, section: 0)
            //let cell: GuestDetailCell = self.tableView.cellForRow(at: index) as! GuestDetailCell
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "GuestDetailCell", for: index) as! GuestDetailCell
            
            var title2 = ""
            var surname2 =  ""
            var firstname2 = ""
            var gender2 = ""
            
            
//            let title = cell.title.text!
//            let surname = cell.surname.text!
//            let firstname = cell.firstname.text!
//            let gender = cell.gender.text!
            
            if(cell.title.text!.isEmpty || cell.surname.text!.isEmpty || cell.firstname.text!.isEmpty || cell.gender.text!.isEmpty)
            {
                print("empty String")
                validationArray.append("Empty")
            }
            else{
                title2 = cell.title.text!
                surname2 = cell.surname.text!
                firstname2 = cell.firstname.text!
                gender2 = cell.gender.text!
                
            }
            
            
            self.dict = ["title": "\(title2)", "surname": "\(surname2)", "firstname": "\(firstname2)", "gender": "\(gender2)" ]
            
            self.newItems.append(dict)
            
        }
        print(self.newItems)
        
        let jsonString = convertIntoJSONString(arrayObject: self.newItems)
        print("jsonString - \(jsonString!)")
        
        StructOperation.glovalVariable.guestDeatils = jsonString!
 
        if(validationArray.isEmpty == true)
        {
        
        // Use them like regular Swift objects
        let hotel = HotelData()
        hotel.location =      StructOperation.glovalVariable.location
        hotel.checkin =       StructOperation.glovalVariable.checkin
        hotel.checkout =      StructOperation.glovalVariable.checkout
        
        hotel.hotelfare =     StructOperation.glovalVariable.hotelFare
        hotel.room =          StructOperation.glovalVariable.totalroom
        hotel.guestDeatils =  StructOperation.glovalVariable.guestDeatils
        hotel.hotelname =  StructOperation.glovalVariable.hotelname
        //hotel.adult = StructOperation.glovalVariable.
        
        getRealm { (realm) in
            try! realm.write {
                realm.add(hotel)
                print(hotel)
            }
        }
        
        print("hotel data inserted")
        
        customAlert()
        
        }
        else{
            showToast(controller: self, message: "Field Required!", seconds: 1)
        }
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
            
            let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
            
            self.navigationController?.pushViewController(secondVC, animated: true)
            
        }
        
        // Add the actions
        alertController.addAction(addmore)
        alertController.addAction(goToCart)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    func convertIntoJSONString(arrayObject: [Any]) -> String? {
        
        do {
            let jsonData: Data = try JSONSerialization.data(withJSONObject: arrayObject, options: [])
            if  let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue) {
                return jsonString as String
            }
            
        } catch let error as NSError {
            print("Array convertIntoJSON - \(error.description)")
        }
        return nil
    }
    
    
    
}

extension GuestNames: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (self.totalcount != 1){
            return "Other Guests Details :"
        }
        return nil
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.totalcount! - 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:GuestDetailCell = self.tableView.dequeueReusableCell(withIdentifier: "GuestDetailCell") as! GuestDetailCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        //cell.isUserInteractionEnabled = false;
        
        cell.guestLbl?.text = "Guest \(indexPath.row + 2)"
        
        return cell
        
    }
}

extension GuestNames: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Verify all the conditions
        if let sdcTextField = textField as? SDCTextField {
            return sdcTextField.verifyFields(shouldChangeCharactersIn: range, replacementString: string)
        }
        return true
    }
}
