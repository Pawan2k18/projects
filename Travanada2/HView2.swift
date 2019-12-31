//
//  HView2.swift
//  Travanada2
//
//  Created by Pawan Dey on 06/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase


class HView2: UIViewController {
    
    var firebaseUid = ""
    var firebaseEmail = ""
    let euroSign = "\u{20AC}"
    
    var totalcount:Int?
    @IBOutlet var mainView: UIView!
    
    @IBOutlet weak var tableView: UITableView!

    var newItems = [[String:String]]()
    var dict = [String:String]()
    
    
    @IBOutlet weak var mytitle: DropDown!
    @IBOutlet weak var mysurname: SDCTextField!
    @IBOutlet weak var myfirstname: SDCTextField!
    @IBOutlet weak var mycountryTerritory: DropDown!
    @IBOutlet weak var myphoneNum: SDCTextField!
    @IBOutlet weak var myemail: SDCTextField!
    @IBOutlet weak var mygender: DropDown!
    @IBOutlet weak var mydobday: SDCTextField!
    @IBOutlet weak var mydobmonth: SDCTextField!
    @IBOutlet weak var mydobyear:SDCTextField!

    @IBOutlet weak var triptype: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var fromDate: UILabel!
    @IBOutlet weak var to: UILabel!
    @IBOutlet weak var totalTicket: UILabel!
    @IBOutlet weak var flightFare: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //cell.selectionStyle = .none
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        self.navigationController?.isNavigationBarHidden = false;
        let user = Auth.auth().currentUser
                if let user = user {
                    self.firebaseUid = user.uid
                    self.firebaseEmail = user.email!
                }
        
        self.myemail.text = firebaseEmail
        
        
        
        self.myphoneNum.delegate = self
        self.mydobday.delegate = self
        self.mydobmonth.delegate = self
        self.mydobyear.delegate = self
    
        self.myphoneNum.valueType = .onlyNumbers
        self.mydobday.valueType = .onlyNumbers
        self.mydobmonth.valueType = .onlyNumbers
        self.mydobyear.valueType = .onlyNumbers
        
        self.myphoneNum.maxLength = 10
        self.mydobday.maxLength = 2
        self.mydobmonth.maxLength = 2
        self.mydobyear.maxLength = 4
    
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
        
        
        self.triptype?.text = (StructOperation.flightDetails.flightType == "onewayselected" ? "One Way Flight" : "Round trip Flight")
        self.from?.text = StructOperation.flightDetails.from
        self.fromDate?.text = StructOperation.flightDetails.departDate
        self.to?.text = StructOperation.flightDetails.to
        self.totalTicket?.text = String("\(StructOperation.flightDetails.totalTraveller) ticket- \(StructOperation.flightDetails.adults) adult ,\(StructOperation.flightDetails.children) child")
        
        self.flightFare?.text = "\(self.euroSign) \(StructOperation.flightDetails.totalfare)"
        
        
        self.totalcount = StructOperation.flightDetails.totalTraveller
        

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let nib = UINib.init(nibName: "PassengerDetailsCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PassengerDetailsCell")
        
         //tableView.register(UINib(nibName: "PassengerDetailsCell", bundle: nil), forCellReuseIdentifier: "PassengerDetailsCell")
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.mainView.frame.origin.y == 0 {
                self.mainView.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.mainView.frame.origin.y != 0 {
            self.mainView.frame.origin.y = 0
        }
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
   
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        view.endEditing(true)
//    }
    
    
    
    @IBAction func submitBtn(_ sender: Any) {
     var validationArray = [String]()
        
        print("validationArray-\(validationArray)")
        
        var title = ""
        var surname =  ""
        var firstname = ""
        var gender = ""
        var dobday = ""
        var dobmonth = ""
        var dobyear = ""
        var counTer = ""
        var phone = ""
        var email = ""
        
        if(mytitle.text!.isEmpty || mysurname.text!.isEmpty || myfirstname.text!.isEmpty || mygender.text!.isEmpty || mydobday.text!.isEmpty || mydobmonth.text!.isEmpty || mydobyear.text!.isEmpty || mycountryTerritory.text!.isEmpty || myphoneNum.text!.isEmpty || myemail.text!.isEmpty)
        {
    
            print("empty String")
            validationArray.append("Empty")
        
        }
        
        
            
        else{
            title = mytitle.text!
            surname = mysurname.text!
            firstname = myfirstname.text!
            gender = mygender.text!
            dobday = mydobday.text!
            dobmonth = mydobmonth.text!
            dobyear = mydobyear.text!
            counTer = mycountryTerritory.text!
            phone = myphoneNum.text!
            email = myemail.text!
            
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            
            let dict2 = ["title": "\(title)", "surname": "\(surname)", "firstname": "\(firstname)", "gender": "\(gender)", "dobday": "\(dobday)", "dobmonth": "\(dobmonth)", "dobyear": "\(dobyear)", "counTer": "\(counTer)", "phone": "\(phone)", "email": "\(email)"]
            
            self.newItems.append(dict2)
            
            
        }
        
        
//
//
//        else
//        {
//            validationArray.append("Passenger 1 Title required !")
//        }
//
//        if(mysurname.text != "")
//        {
//            surname = mysurname.text!
//        }else
//        {
//            validationArray.append("Passenger 1 surname required !")
//        }
//
//        if(myfirstname.text != "")
//        {
//            firstname = myfirstname.text!
//        }else
//        {
//            validationArray.append("Passenger 1 firstname required !")
//        }
//
//        if(mygender.text != "")
//        {
//            gender = mygender.text!
//        }else
//        {
//            validationArray.append("Passenger 1 gender required !")
//        }
//        if(mydobday.text != "")
//        {
//            dobday = mydobday.text!
//        }else
//        {
//            validationArray.append("Passenger 1 dobday required !")
//        }
//
//        if(mydobmonth.text != "")
//        {
//            dobmonth = mydobmonth.text!
//        }else
//        {
//            validationArray.append("Passenger 1 dobmonth required !")
//        }
//        if(mydobyear.text != "")
//        {
//            dobyear = mydobyear.text!
//        }else
//        {
//            validationArray.append("Passenger 1 mydobyear required !")
//        }
//
//        if(mycountryTerritory.text != "")
//        {
//            counTer = mycountryTerritory.text!
//        }else
//        {
//            validationArray.append("Passenger 1 mycountryTerritory required !")
//        }
//        if(myphoneNum.text != "")
//        {
//            phone = myphoneNum.text!
//        }else
//        {
//            validationArray.append("Passenger 1 myphoneNum required !")
//        }
//
//        if(myemail.text != "")
//        {
//            email = myemail.text!
//        }else
//        {
//            validationArray.append("Passenger 1 myemail required !")
//        }
//
        
//        surname = mysurname.text!
//        firstname = myfirstname.text!
//        gender = mygender.text!
//        dobday = mydobday.text!
//        dobmonth = mydobmonth.text!
//        dobyear = mydobyear.text!
//        counTer = mycountryTerritory.text!
//        phone = myphoneNum.text!
//        email = myemail.text!
        
       
        
        for totrows in 0 ..< self.totalcount! - 1 {
         
            let index = IndexPath(row: totrows, section: 0)
             let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerDetailsCell", for: index) as! PassengerDetailsCell
            
            //let cell: PassengerDetailsCell = self.tableView.cellForRow(at: index) as! PassengerDetailsCell
            
            var title2 = ""
            var surname2 =  ""
            var firstname2 = ""
            var gender2 = ""
            var dobday2 = ""
            var dobmonth2 = ""
            var dobyear2 = ""
            
            
            if(cell.title.text!.isEmpty || cell.surname.text!.isEmpty || cell.firstname.text!.isEmpty || cell.gender.text!.isEmpty || cell.dobday.text!.isEmpty || cell.dobmonth.text!.isEmpty || cell.dobyear.text!.isEmpty)
            {
                print("empty String")
                validationArray.append("Empty")
            }
            
            
//            if(cell.title.text == "")
//            {
//                 validationArray.append("Passenger \(totrows+2) title required !")
//
//            }else
//            {
//                title2 =  cell.title.text!
//            }
//
//            if(cell.surname.text == "")
//            {
//                surname2 = cell.surname.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) surname required !")
//            }
//
//            if(cell.firstname.text == "")
//            {
//                firstname2 = cell.firstname.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) firstname required !")
//            }
//
//            if(cell.gender.text == "")
//            {
//                gender2 = cell.gender.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) gender required !")
//            }
//            if(cell.dobday.text == "")
//            {
//                dobday2 = cell.dobday.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) dobday required !")
//            }
//
//            if(cell.dobmonth.text == "")
//            {
//                dobmonth2 = cell.dobmonth.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) dobmonth required !")
//            }
//            if(cell.dobyear.text == "")
//            {
//                dobyear2 = cell.dobyear.text!
//            }else
//            {
//                validationArray.append("Passenger \(totrows+2) mydobyear required !")
//            }
//
            
            else{
                title2 = cell.title.text!
                surname2 = cell.surname.text!
                firstname2 = cell.firstname.text!
                gender2 = cell.gender.text!
                dobday2 = cell.dobday.text!
                dobmonth2 = cell.dobmonth.text!
                dobyear2 = cell.dobyear.text!
           
                
            }
            self.dict = ["title": "\(title2)", "surname": "\(surname2)", "firstname": "\(firstname2)", "gender": "\(gender2)", "dobday": "\(dobday2)", "dobmonth": "\(dobmonth2)", "dobyear": "\(dobyear2)" ]
            
            self.newItems.append(dict)
            
        }
        
        print(self.newItems)
        let jsonString = convertIntoJSONString(arrayObject: self.newItems)
        print("jsonString - \(jsonString!)")
        StructOperation.flightDetails.passengerDetails = jsonString!
        
        if(validationArray.isEmpty == true)
        {

            // Use them like regular Swift objects
            let flight = FlightData()
            flight.from =           StructOperation.flightDetails.from
            flight.to =             StructOperation.flightDetails.to
            flight.jdate =          StructOperation.flightDetails.departDate
            flight.rdate =          StructOperation.flightDetails.returnDate
            flight.adult =          StructOperation.flightDetails.adults
            flight.child =          StructOperation.flightDetails.children
            flight.infant =         StructOperation.flightDetails.infants
            flight.totalTraveller = StructOperation.flightDetails.totalTraveller
            flight.flightType =     StructOperation.flightDetails.flightType
            flight.classtype =      StructOperation.flightDetails.classtype
            flight.flightFare =      StructOperation.flightDetails.totalfare
            flight.passengerDeatils = StructOperation.flightDetails.passengerDetails
    
        
            getRealm { (realm) in
                try! realm.write {
                    realm.add(flight)
                    print(flight)
                }
            }
    
            print("flight data inserted")
        
        customAlert2()
            
        }else {
            showToast(controller: self, message: "Field Required!", seconds: 1)
        }
        
    }
    
    
        func customAlert2(){
            let alert = UIAlertController(title: "Travanada", message: "Added to Cart" , preferredStyle: UIAlertController.Style.alert)

            let defaultAction: UIAlertAction = UIAlertAction(title: "Go to Cart", style: UIAlertActionStyle.default, handler: {(action) -> Void in

                let storyboard : UIStoryboard = UIStoryboard(name: "Main2", bundle: nil)
                let vc : CartViewController = storyboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
                
                let navigationController = UINavigationController(rootViewController: vc)
                
                self.present(navigationController, animated: true, completion: nil)

            })
            
            let defaultAction2: UIAlertAction = UIAlertAction(title: "Back to Home", style: UIAlertActionStyle.default, handler: {(action) -> Void in
                
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc : HomeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                
                let navigationController = UINavigationController(rootViewController: vc)
                
                self.present(navigationController, animated: true, completion: nil)
                
            })
    
            alert.addAction(defaultAction)
            alert.addAction(defaultAction2)
            self.present(alert, animated: true, completion: nil)
  
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

extension HView2: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        if (self.totalcount != 1){
            return "Other Passenger Details :"
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
        return 484.0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //let cell:PassengerDetailsCell = self.tableView.dequeueReusableCell(withIdentifier: "PassengerDetailsCell") as! PassengerDetailsCell
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PassengerDetailsCell") as! PassengerDetailsCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none;
        //cell.isUserInteractionEnabled = false;
        
        cell.passengerLbl?.text = "Passenger \(indexPath.row + 2)"
        
//        cell.title?.delegate = self
//        cell.title?.text = ""
//        cell.title?.placeholder = "Mr."
//        cell.title?.autocorrectionType = UITextAutocorrectionType.no
//        cell.title?.autocapitalizationType = UITextAutocapitalizationType.none
//        cell.title?.adjustsFontSizeToFitWidth = true;
        
        return cell
        
    }
}



extension HView2: UITextFieldDelegate {

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

