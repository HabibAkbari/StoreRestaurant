//
//  FoodsCategoriseCollectionViewCell.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit


class FoodsCategoriseCollectionViewCell: UICollectionViewCell {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var categoriseTitleLabel: UILabel!
    @IBOutlet weak var categoriseImage: UIImageView!
    @IBOutlet var imageCategorise: UIImageView!
    @IBOutlet weak var groupCellView: UIView!
    
    //MARK: - FUNC
    func configCell(imageCategory: String,titleCategory: String) {
    
        do {
            
            let url = NSURL(string:"\(String(describing:imageCategory))")!
            let dataImage = NSData(contentsOf: url as! URL)
            
            try categoriseImage.image = UIImage(data: dataImage as! Data)
            categoriseTitleLabel.text = String(describing: titleCategory.capitalized)
            
                
            
        } catch  {
            
            print(error.localizedDescription)
        }
    
        
    }

}
