//
//  CartTableViewCell.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit


class CartTableViewCell: UITableViewCell {
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
    @IBOutlet var itemLabel: UILabel!
    @IBOutlet var itemStepper: UIStepper!
    @IBOutlet weak var stepper: GMStepper!
    @IBOutlet weak var step: GMStepper!
    
    
    //MARK: - VAR
    weak var setRemaining : SetRemainingValue?
    lazy var productPriceFormatter : NumberFormatter = {
        let productPriceFormatter = NumberFormatter()
        productPriceFormatter.numberStyle = .currency
        productPriceFormatter.locale = NSLocale.current
        return productPriceFormatter
    }()
    
    
    //MARK: - IBACTION FUNC
    @IBAction func step(_ sender: Any) {
        

        
        let indexPath = NSIndexPath(row: step.tag, section: 0)
        
        
        countItem = Int(step.value)
        buyArray[indexPath.row].count = Int(step.value)
        
        let separat = itemPriceLabel.text?.components(separatedBy: "$")
        
        let priceTotleRow = calculatPriceItem(price: Float(separat![1])!, indexPathRow:indexPath.row)
        
        itemPriceLabel.text = productPriceFormatter.string(from: NSNumber(value: priceTotleRow))
        

        buyArray[indexPath.row].totle = priceTotleRow
        
        _ = updateTotalConstsLabel()
        
        print(updateTotalConstsLabel())
        let cartViewController = CartViewController()

        setRemaining?.setValue(amount: updateTotalConstsLabel())
        
    }
    
    @IBAction func increaseStepper(_ sender: Any) {
        
        
        print(Int(step.value))
        
        let indexPath = NSIndexPath(row: itemStepper.tag, section: 0)
        
        print(indexPath)
        
        countItem = Int(step.value)
        buyArray[indexPath.row].count = Int(step.value)
        
        let separat = itemPriceLabel.text?.components(separatedBy: "$")
        
        let priceTotleRow = calculatPriceItem(price: Float(separat![1])!, indexPathRow:indexPath.row)
        
        itemPriceLabel.text = productPriceFormatter.string(from: NSNumber(value: priceTotleRow))
        
        // print(calculatPriceItem(price: Float(separat![1])!))
        buyArray[indexPath.row].totle = priceTotleRow
        
        _ = updateTotalConstsLabel()
        print(updateTotalConstsLabel())
       
        setRemaining?.setValue(amount: updateTotalConstsLabel())
        
        
    }
    
    @IBAction func increaseItem(_ sender: UIStepper) {
        
        let indexPath = NSIndexPath(row: itemStepper.tag, section: 0)
        let plass =  String(sender.value)
        let plas =  plass.components(separatedBy: ".")
        
        itemLabel.text = plas[0]
        countItem = Int(sender.value)
        buyArray[indexPath.row].count = Int(sender.value)
        
        
        let separat = itemPriceLabel.text?.components(separatedBy: "$")
        let priceTotleRow = calculatPriceItem(price: Float(separat![1])!, indexPathRow:indexPath.row)
        itemPriceLabel.text = productPriceFormatter.string(from: NSNumber(value: priceTotleRow))
        

        buyArray[indexPath.row].totle = priceTotleRow
        _ = updateTotalConstsLabel()
        
        let tabBar : UITabBarController = (self.window?.rootViewController as? UITabBarController)!
        
        tabBar.selectedIndex = 1
        tabBar.selectedIndex = 2
        
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
