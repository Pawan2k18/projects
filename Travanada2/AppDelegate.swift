//
//  AppDelegate.swift
//  Travanada2
//
//  Created by Pawan Dey on 06/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit
import Firebase

let primaryColor = UIColor(red: 58/255, green: 38/255, blue: 180/255, alpha: 1.0) /* #3a26b4 */
let secondaryColor = UIColor(red: 110/255, green: 25/255, blue: 163/255, alpha: 1.0) /* #6e19a3 */

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
     
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//
//        let storyboard = UIStoryboard(name: "Main2", bundle: nil)
//
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "PasseengerDetail")
//
//        self.window?.rootViewController = initialViewController
//        self.window?.makeKeyAndVisible()
        
        
        
        
        
        // Set navigation bar tint / background colour
        //UINavigationBar.appearance().barTintColor = UIColor.red
        
        //UIApplication.shared.statusBarStyle = .lightContent
        
        // Set Navigation bar Title colour
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        
        // Set navigation bar ItemButton tint colour
        UIBarButtonItem.appearance().tintColor = UIColor.white
        
        // Set Navigation bar background image
//        let navBgImage:UIImage = UIImage(named: "navbarblue")!
//        UINavigationBar.appearance().setBackgroundImage(navBgImage, for: .default)
        
    
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.tintColor = UIColor(hexString: "#ffffff");
        navigationBarAppearace.barTintColor = UIColor(hexString: "#2CB4FF")
        
    
        //Set navigation bar Back button tint colour
        UINavigationBar.appearance().tintColor = UIColor.white
        
    
        FirebaseApp.configure()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
     
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

