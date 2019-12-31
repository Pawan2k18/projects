//
//  CollectionViewViewController.swift
//  Travanada2
//
//  Created by Pawan Dey on 24/06/19.
//  Copyright © 2019 nibble. All rights reserved.
//

import UIKit

class CollectionViewViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    var imageArray = [UIImage(named: "city1"),UIImage(named: "city2"),UIImage(named: "city3"),UIImage(named: "city4"),UIImage(named: "city5")]
    
    var cellTitle = ["Bangkok", "New York", "Canada", "Australia", "Russia"]
    
     var cellSubTitle = ["Thailand", "US", "America", "Australia", "Russia"]
    
     var cellFlightsAvailable = ["29 flights available", "42 flights available", "47 flights available", "25 flights available", "39 flights available"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgViewCollectionCell.image = imageArray[indexPath.row]
        cell.cellTitle.text = cellTitle[indexPath.row]
        cell.cellSubTitle.text = cellSubTitle[indexPath.row]
        cell.cellFlightsAvailable.text = cellFlightsAvailable[indexPath.row]
        
        cell.contentView.layer.cornerRadius = 5
        cell.contentView.layer.borderWidth = 1.0
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        cell.contentView.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.lightGray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 1.0
        cell.layer.masksToBounds = true
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected cell - \(indexPath.item)")
        
    
        
    }
    
}
