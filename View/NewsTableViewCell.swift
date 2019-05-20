//
//  NewsTableViewCell.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/6/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var newsImage: UIImageView!
    @IBOutlet var titleNewsLabel: UILabel!
    @IBOutlet var timeNewsLabel: UILabel!
    @IBOutlet var newsLabel: UILabel!
    
    
    //MARK: - FUNC
    func configCell(newsRow: [String:AnyObject]) {
     
        titleNewsLabel.text = String(describing: newsRow["title"]!)
        timeNewsLabel.text = String(describing: newsRow["date"]!)
        
        let url = NSURL(string: "\(newsRow["image"] as! String)")!
        let data = NSData(contentsOf: url as URL)
        newsImage.image = UIImage(data: data as! Data)
        
        newsLabel.text = String(describing: newsRow["news"]!)

        
    }
    

    //MARK: - OVERRIDE FUNC
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
