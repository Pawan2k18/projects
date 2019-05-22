//
//  SelectedRowViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 20/05/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class SelectedRowViewController: UIViewController {

    var lbl1:String!
    var lbl2:String!
    var imgView2:UIImage!
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!

        override func viewDidLoad() {
        super.viewDidLoad()

        label1.text = lbl1
        label2.text = lbl2
        img.image = imgView2
        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
