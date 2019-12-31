//
//  PasseengerDetail.swift
//  Travanada2
//
//  Created by Pawan Dey on 29/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit


class PasseengerDetail: UIViewController {

    @IBOutlet weak var mytitle: SDCTextField!
    @IBOutlet weak var surnameField: SDCTextField!
    @IBOutlet weak var firstnameFiled: SDCTextField!
    @IBOutlet weak var emailid: SDCTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //getUserDetails()
        
        self.mytitle.delegate = self
        self.mytitle.maxLength = 2
        //self.title.valueType = .onlyLetters
        self.mytitle.valueType = .onlyNumbers
        
        self.surnameField.delegate = self
        self.surnameField.maxLength = 10
        self.surnameField.valueType = .onlyLetters
        //self.surnameField.valueType = .onlyNumbers
        
        
    }
    
//    func getUserDetails(){
//        let user = Auth.auth().currentUser
//        if let user = user {
//            let uid = user.uid
//            let email = user.email!
//
//            print("uid - \(uid)")
//            print("email - \(email)")
//
//            firstnameFiled.text = uid
//            emailid.text = email
//        }
//    }
//
    
    
    @IBAction func gotoCart(_ sender: UIBarButtonItem) {
        print("presese")
        let listVc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.navigationController?.pushViewController(listVc, animated: true)
    }

    @IBAction func backtoHome(_ sender: UIBarButtonItem) {
        print("presese")
        let nextstoryboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = nextstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
         self.navigationController?.pushViewController(secondVC, animated: true)
    }

    
    
    @IBAction func submitBtn(_ sender: Any) {
        
        if (self.surnameField.text!.isEmpty || self.mytitle.text!.isEmpty || self.firstnameFiled.text!.isEmpty) {
           print("empty filed")
            
        }
        else{
            gotoNextView()
        }
    }

    func gotoNextView(){
        print("asdhashdhjasjdkl")
    }
    
}


extension PasseengerDetail: UITextFieldDelegate {
    
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
