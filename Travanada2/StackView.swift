//
//  StackView.swift
//  Travanada2
//
//  Created by Pawan Dey on 24/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import Foundation
import UIKit

class StackView: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addViewButton()
    }
    
    func addViewButton() {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        customView.backgroundColor = UIColor.white
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        let button2 = UIButton(frame: CGRect(x: 120, y: 0, width: 100, height: 50))
        button.setTitle("Cart", for: .normal)
        button2.setTitle("Book", for: .normal)
        button.addTarget(self, action: #selector(buttonActionCart), for: .touchUpInside)
        button2.addTarget(self, action: #selector(buttonActionBook), for: .touchUpInside)
    
        customView.addSubview(button)
        customView.addSubview(button2)
    
        self.tableView.tableFooterView = customView
}


@objc func buttonActionCart(_ sender: UIButton!) {
    print("Cart tapped")
}

@objc func buttonActionBook(_ sender: UIButton!) {
    print("Book tapped")
}

    
    
}
