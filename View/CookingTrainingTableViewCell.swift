//
//  CookingTrainingTableViewCell.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/16/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class CookingTrainingTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var cookingTrainingImage: UIImageView!
    @IBOutlet var titleCookingTrainingLabel: UILabel!
    @IBOutlet var descriptionCookingTrainingLabel: UILabel!
    
    
    //MARK: - FUNC
    func updateCell(cookingTraining:[String:AnyObject]) {

        let url = NSURL(string: "\(cookingTraining["image"]!)")
        let data = NSData(contentsOf: url as! URL)
        cookingTrainingImage.image = UIImage(data: data as! Data)
        
        titleCookingTrainingLabel.text = cookingTraining["title"] as? String
        descriptionCookingTrainingLabel.text = cookingTraining["discription"] as? String
    }


    //MARK: - OVERRIDE FUNC
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
