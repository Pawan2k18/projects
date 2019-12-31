//
//  StackViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 24/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class StackViewController: UIViewController {

    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var fliTap: UIButton!
    @IBOutlet weak var hotelTap: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func fliBtnTap(_ sender: UIButton) {
        let xPosition = view2.frame.origin.x
        
        //will moview view up by 20px
        let yPosition = view2.frame.origin.y
        let height = view2.frame.size.height
        let width = view2.frame.size.width
        
        print("xPosition- \(xPosition)")
        print("yPosition- \(yPosition)")
        print("height- \(height)")
        print("width- \(width)")
        
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view1.frame.size.height = 150;
            self.view2.frame.origin.y += 150;
            self.searchBtn.frame.origin.y += 150;
            self.searchBtn.alpha = 1;
        })
        
        fliTap.isUserInteractionEnabled = false
        fliTap.setImage(UIImage(named: "flight.png"), for: .normal)
        
        //searchBtn.isHidden = false
        //searchBtn.alpha = 1
    }
    
    
    @IBAction func hotelBtnTap(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view3.frame.size.height = 150;
            //self.view2.frame.origin.y += 400
        })
        
        hotelTap.isUserInteractionEnabled = false
    }
    
    
    @IBAction func createView(_ sender: Any) {
        
        let view1 = UIView(frame: CGRect(x: 16, y: 220, width: 343, height:150))
        let view2 = UIView(frame: CGRect(x: 16, y: 400, width: 343, height:150))
        view1.backgroundColor = .black
        view2.backgroundColor = .blue
        
        let tap = CGPoint(x:10 , y:10)
        let convertedTap = view1.convert(tap, to: view2)
        
    }
    

}
