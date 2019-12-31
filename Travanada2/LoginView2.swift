//
//  LoginView2.swift
//  Travanada2
//
//  Created by Pawan Dey on 23/08/19.
//  Copyright © 2019 nibble. All rights reserved.
//


import Foundation
import UIKit
import Firebase


class LoginView2: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var useridView: UIView!
    
    @IBOutlet weak var passView: UIView!
    
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var btnView: UIView!
    
    @IBOutlet weak var gotoSignupBtn: UIButton!
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    @IBOutlet weak var dismissButton: UIButton!
    
     var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailField.delegate = self
        passwordField.delegate = self
        
        setDesign()
        
        setContinueButton(enabled: false)
        loginBtn.alpha = 0.5
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = loginBtn.center

        view.addSubview(activityView)
        
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
    }
    
    @IBAction func SignUpNow(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailField.text
        let password = passwordField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    
    
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            loginBtn.alpha = 1.0
            loginBtn.isEnabled = true
        } else {
            loginBtn.alpha = 0.5
            loginBtn.isEnabled = false
        }
    }
    
    @objc func handleSignIn() {
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        setContinueButton(enabled: false)
        loginBtn.setTitle("", for: .normal)
        activityView.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.becomeFirstResponder()
         NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        loginBtn.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - loginBtn.frame.height / 2)
        activityView.center = loginBtn.center
    }
    
    
    
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)

    }
    
  
    @IBAction func LoginBtn(_ sender: UIButton) {
        
        guard let email = emailField.text else { return }
        guard let pass = passwordField.text else { return }
        
        loginBtn.isEnabled = false
        loginBtn.setTitle("", for: .normal)
        activityView.startAnimating()
        
        Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                
                self.customAlert()
                
            }
        }
    }
    
    
    func customAlert(){
        
        let alert = UIAlertController(title: "Alert", message: "Error- Wrong Input", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func setDesign(){
        let color1 = hexStringToUIColor(hex: "#2CB4FF")
        
        useridView.layer.borderWidth = 0.5
        passView.layer.borderWidth = 0.5
        useridView.layer.borderColor = color1.cgColor
        passView.layer.borderColor = color1.cgColor
        useridView.layer.cornerRadius = self.useridView.bounds.height * 0.5
        passView.layer.cornerRadius = self.passView.bounds.height * 0.5
        
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
 

}



