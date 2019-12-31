//
//  PaymentView.swift
//  Travanada2
//
//  Created by Pawan Dey on 13/09/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import RealmSwift


class PaymentView: UIViewController {

    @IBOutlet weak var totalFareLbl: UILabel!
    @IBOutlet weak var cardNumber: SDCTextField!
    @IBOutlet weak var expYear: SDCTextField!
    @IBOutlet weak var expMonth: SDCTextField!
    @IBOutlet weak var cvv: SDCTextField!
    @IBOutlet weak var holderName: SDCTextField!
    
    var totalFare:Double = 0.0
      let euroSign = "\u{20AC}"
    
    
    let payment = PaymentDeatils()
    let BookingRef = BookingID()
    
    var uuid = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.hidesBackButton = true;
        self.navigationController?.isNavigationBarHidden = true;
        
        
        let totalFareRound = Double(round(100*self.totalFare)/100)
        print("totalFareRound- \(totalFareRound)")  // 299.96
        
        
        totalFareLbl?.text = "\(euroSign) \(StructOperation.TotalFareForPayment.totalFare)"
        
        self.cardNumber.delegate = self
        self.expYear.delegate = self
        self.expMonth.delegate = self
        self.cvv.delegate = self
        self.holderName.delegate = self
        
        self.cardNumber.valueType = .onlyNumbers
        self.expYear.valueType = .onlyNumbers
        self.expMonth.valueType = .onlyNumbers
        self.cvv.valueType = .onlyNumbers
        self.holderName.valueType = .onlyLetters

        
        self.cardNumber.maxLength = 16
        self.expYear.maxLength = 2
        self.expMonth.maxLength = 2
        self.cvv.maxLength = 3
        self.holderName.maxLength = 50
    
        
    }
    

    @IBAction func makePaymentBtn(_ sender: Any) {
        
        uuid = String(UUID().uuidString.prefix(8))
        StructOperation.bookingRef.bookingid = uuid
        
        if (cardNumber.text?.isEmpty == false && expYear.text?.isEmpty == false && expMonth.text?.isEmpty == false && cvv.text?.isEmpty == false && holderName.text?.isEmpty == false){
        
        payment.cardNumber = cardNumber.text!
        payment.expYear = expYear.text!
        payment.expMonth = expMonth.text!
        payment.cvv = cvv.text!
        payment.holdername = holderName.text!
        payment.totalFare = self.totalFare
        
        BookingRef.bookingref = uuid
        
//        getRealm { (realm) in
//            try! realm.write {
//                realm.add(self.payment)
//                realm.add(self.BookingRef)
//                print(self.payment)
//                print(self.BookingRef)
//            }
//        }
//

                let realm = try! Realm()
                do {
                    try realm.write({
                        realm.add(self.payment)
                        realm.add(self.BookingRef)
                        print(self.payment)
                        print(self.BookingRef)
                    })
                }catch let error {
                    print(error)
                }
            
            
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            
            let nextstoryboard = UIStoryboard(name: "Main2", bundle: nil)
            let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "BookingView") as! BookingView
            
            self.present(secondVC, animated: true)
        }
        }
        
        else{
            showToast(controller: self, message: "Field Required!", seconds: 1)
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
    
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        customAlert2()
    }
    
    func customAlert(){
        // Create the alert controller
        let alertController = UIAlertController(title: "Travanada", message: "Really You want to Cancel", preferredStyle: .alert)
        
     
        let goToCart = UIAlertAction(title: "Back To Home", style: UIAlertActionStyle.cancel) {
            
            UIAlertAction in
            NSLog("Cancel Pressed")
            
                let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
    
                self.navigationController?.pushViewController(secondVC, animated: true)
        }
        
        alertController.addAction(goToCart)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func customAlert2(){
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
    
    
    
}


extension PaymentView: UITextFieldDelegate {
    
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
