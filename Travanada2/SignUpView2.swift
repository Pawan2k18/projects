//
//  SignUpView2.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//


import Foundation
import UIKit
import Firebase

class SignUpView2:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var userIdView: UIView!
    
    @IBOutlet weak var mailView: UIView!
    
    @IBOutlet weak var passView: UIView!
    
    @IBOutlet weak var btnView: CardViewShadowEffect!
    
    @IBOutlet weak var gotoLoginBtn: UIButton!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var signUpBtn: UIButton!
    
    
    //var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDesign()
      
        signUpBtn.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = signUpBtn.center
        
        view.addSubview(activityView)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        usernameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    func setDesign(){
        let color1 = hexStringToUIColor(hex: "#2CB4FF")
        
        userIdView.layer.borderWidth = 0.5
        passView.layer.borderWidth = 0.5
        mailView.layer.borderWidth = 0.5
        userIdView.layer.borderColor = color1.cgColor
        passView.layer.borderColor = color1.cgColor
        mailView.layer.borderColor = color1.cgColor
        userIdView.layer.cornerRadius = self.userIdView.bounds.height * 0.5
        passView.layer.cornerRadius = self.passView.bounds.height * 0.5
        mailView.layer.cornerRadius = self.passView.bounds.height * 0.5
        btnView.layer.cornerRadius = self.btnView.bounds.height * 0.5
        
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    
    @IBAction func loginNow(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    
    @IBAction func handleDismissButton(_ sender: Any) {
       
       self.dismiss(animated: false, completion: nil)
        
    }
    

    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        signUpBtn.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - signUpBtn.frame.height / 2)
        activityView.center = signUpBtn.center
    }
    
 
    @objc func textFieldChanged(_ target:UITextField) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case usernameField:
            usernameField.resignFirstResponder()
            emailField.becomeFirstResponder()
            break
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
   
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            signUpBtn.alpha = 1.0
            signUpBtn.isEnabled = true
        } else {
            signUpBtn.alpha = 0.5
            signUpBtn.isEnabled = false
        }
    }
    
    
    @objc func handleSignUp() {
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        setContinueButton(enabled: false)
        signUpBtn.setTitle("", for: .normal)
        activityView.startAnimating()
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                
                changeRequest?.commitChanges { error in
                    if error == nil {
                        print("User display name changed!")
                        
                        
                        let defaults = UserDefaults.standard
                        
                        if let DepAirportName = defaults.string(forKey: "DepAirportName") {
                            print("DepAirportName--- \(DepAirportName)")
                        }
                        
                        if let ArrAirportName = defaults.string(forKey: "ArrAirportName") {
                            print("ArrAirportName--- \(ArrAirportName)")
                        }
                        
                        if let DepAirportTime = defaults.string(forKey: "DepAirportTime") {
                            print("DepAirportTime--- \(DepAirportTime)")
                        }
                        if let ArrAirportTime = defaults.string(forKey: "ArrAirportTime") {
                            print("ArrAirportTime--- \(ArrAirportTime)")
                        }
                        
                        if let DepAirportDate = defaults.string(forKey: "DepAirportDate") {
                            print("DepAirportDate--- \(DepAirportDate)")
                        }
                        
                        if let ArrAirportDate = defaults.string(forKey: "ArrAirportDate") {
                            print("ArrAirportDate--- \(ArrAirportDate)")
                        }
                        if let DepAirportAddress = defaults.string(forKey: "DepAirportAddress") {
                            print("DepAirportAddress--- \(DepAirportAddress)")
                        }
                        
                        if let ArrAirportAddress = defaults.string(forKey: "ArrAirportAddress") {
                            print("ArrAirportAddress--- \(ArrAirportAddress)")
                        }
                        
                        if let TotalTime = defaults.string(forKey: "TotalTime") {
                            print("TotalTime--- \(TotalTime)")
                        }
                        if let FlightLogo = defaults.string(forKey: "FlightLogo") {
                            print("FlightLogo--- \(FlightLogo)")
                        }
                        
                        if let flightName = defaults.string(forKey: "flightName") {
                            print("flightName--- \(flightName)")
                        }
                        
                        if let flightCode = defaults.string(forKey: "flightCode") {
                            print("flightCode--- \(flightCode)")
                        }
                        
                        
                        //                            self.ref.child("travanada").child("DepAirportName").setValue(DepAirportName)
                        //                            self.ref.child("travanada").child("ArrAirportName").setValue(ArrAirportName)
                        //                            self.ref.child("travanada").child("DepAirportTime").setValue(DepAirportTime)
                        //                            self.ref.child("travanada").child("ArrAirportTime").setValue(ArrAirportTime)
                        //                            self.ref.child("travanada").child("DepAirportDate").setValue(DepAirportDate)
                        //                            self.ref.child("travanada").child("ArrAirportDate").setValue(ArrAirportDate)
                        //                            self.ref.child("travanada").child("DepAirportAddress").setValue(DepAirportAddress)
                        //                            self.ref.child("travanada").child("ArrAirportAddress").setValue(ArrAirportAddress)
                        //                            self.ref.child("travanada").child("TotalTime").setValue(TotalTime)
                        //                            self.ref.child("travanada").child("FlightLogo").setValue(FlightLogo)
                        //                            self.ref.child("travanada").child("flightName").setValue(flightName)
                        //                            self.ref.child("travanada").child("flightCode").setValue(flightCode)
                        
                        
                        
                        //                        DepAirportName
                        //                        ArrAirportName
                        //                        DepAirportTime
                        //                        ArrAirportTime
                        //                        DepAirportDate
                        //                        ArrAirportDate
                        //                        DepAirportAddress
                        //                        ArrAirportAddress
                        //                        TotalTime
                        //                        FlightLogo
                        //                        flightName
                        //                        flightCode
                        
                        
                        
                        
                        
                        self.dismiss(animated: false, completion: nil)
                    } else {
                        print("Error: \(error!.localizedDescription)")
                    }
                }
                
            } else {
                print("Error: \(error!.localizedDescription)")
            }
        }
        
        
    }
    
    
    
}
