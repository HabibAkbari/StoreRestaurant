//
//  FoodsTableViewCell.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class FoodsTableViewCell: UITableViewCell {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var foodsLabel: UILabel!
    @IBOutlet var foodsImage: UIImageView!
    @IBOutlet var foodsPriceLabel: UILabel!
    
    
    //MARK: - FUNC
    func configCell(foodsTitles: [String],foodsDetails: [String:AnyObject]) {
        
        foodsLabel.text = String(foodsTitles[0])
        foodsPriceLabel.text = String(  productPriceFormatter.string(from: NSNumber(value: foodsDetails["price"] as! Float))!)
        let url = NSURL(string: "\(foodsDetails["image"] as! String)")!
        let data = NSData(contentsOf: url as URL)
        foodsImage.image = UIImage(data: data as! Data)
        

    }
    
    
    //MARK: - OVERRIDE FUNC
    override func awakeFromNib() {
        
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }


}
