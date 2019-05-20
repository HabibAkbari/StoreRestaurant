
//
//  CartViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

protocol SetRemainingValue : class  {
    func setValue(amount: String)
}

class CartViewController: UIViewController , UITableViewDataSource, UITableViewDelegate,SetRemainingValue {
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    @IBOutlet weak public var totaleCostsLabel: UILabel!
    @IBOutlet weak var paymentButton: UIButton!
    
    //MARK: - LAZY VAR
    lazy var productPriceFormatter : NumberFormatter = {
        let productPriceFormatter = NumberFormatter()
        productPriceFormatter.numberStyle = .currency
        productPriceFormatter.locale = NSLocale.current
        return productPriceFormatter
    }()
    
    //MARK: - VAR
    var allIndexPath = [AnyObject]()
    // write data for send AddValidCCViewController
    var totalPrice : String {
        
        get {
            return UserDefaults.standard.object(forKey: "totalPrice") as! String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "totalPrice")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Cart"
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.navigationController?.navigationBar.transparentNavigationBar()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Enable Payment Button
        changeEnableAndDisablePaymentButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        checkEmptyStateOfCart()
        tableView.reloadData()
        
        totaleCostsLabel.text = updateTotalConstsLabel()
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    //MARK: - FUNC
    func changeEnableAndDisablePaymentButton() {
        
        let countItem = CartManger.sharedInstance.numberOfItemsInCart()
        if countItem != 0 {
            
            paymentButton.isEnabled = true
            totalPrice = totaleCostsLabel.text!
            
        } else {
            
            paymentButton.isEnabled = false
        }
        
    }
    
    func update() {

        let totle = String(updateTotalConstsLabel())
        
        var totoleConsts : String = updateTotalConstsLabel() {
            
            didSet {
               totaleCostsLabel.text = totoleConsts
            }
        }
       
    }
    
    func checkEmptyStateOfCart() {
        
        setEmptyViewVisible(visible: CartManger.sharedInstance.numberOfItemsInCart() == 0)
        
    }
    
    func setEmptyViewVisible(visible: Bool) {
        
        totaleCostsLabel.text =   updateTotalConstsLabel()
        
        if visible {
            
            clearButton.isEnabled = false
            self.view.bringSubview(toFront: emptyView)
            tableView.isHidden = !visible
            
        } else {
            
            clearButton.isEnabled = true
            self.view.sendSubview(toBack: emptyView)
            
        }
    }
    
    func clearCart() {
        
        for item in allIndexPath {
            
            let cell = tableView.cellForRow(at: item as! IndexPath) as! CartTableViewCell
            cell.step.value = 1
            
        }
        
        CartManger.sharedInstance.clearCart()
        tableView.reloadData()
        setEmptyViewVisible(visible: true)
        tabBarController?.tabBar.items?[2].badgeValue = nil
        
    }
    
    func upadteTotle() {
        totaleCostsLabel.text =   updateTotalConstsLabel()
    }
    
    func setValue(amount: String) {
        totaleCostsLabel.text = amount
    }
    
    func clear() {
        CartManger.sharedInstance.clearCart()
        tableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return CartManger.sharedInstance.numberOfItemsInCart()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        allIndexPath.append(indexPath as AnyObject)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "buyCell") as! CartTableViewCell
        cell.step.tag = indexPath.row
        let product = CartManger.sharedInstance.productAtIndexPath(indexPath: indexPath as NSIndexPath)
        
        cell.itemNameLabel.text = product.title
        let url = NSURL(string: product.image)
        let data = NSData(contentsOf: url as! URL)
        
        cell.productImage.image = UIImage(data: data as! Data)
        cell.itemPriceLabel.text = productPriceFormatter.string(from: NSNumber(value:product.totalPrice()))
        cell.setRemaining = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let cell = tableView.cellForRow(at: indexPath) as! CartTableViewCell
            cell.step.value = 1
            
            let product = CartManger.sharedInstance.productAtIndexPath(indexPath: indexPath as NSIndexPath)
            let successful = CartManger.sharedInstance.removeProduct(product: product)
            
            if successful == true {
                
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
                changeEnableAndDisablePaymentButton()
                let countItem = CartManger.sharedInstance.numberOfItemsInCart()
                if countItem != 0 {
                    
                    tabBarController?.tabBar.items?[2].badgeValue = "\(countItem)"
                    
                } else {
                    tabBarController?.tabBar.items?[2].badgeValue = nil
                }
                
                tableView.endUpdates()
            }
            checkEmptyStateOfCart()
        }
        
    }
    
    
    
    //MARK: - IBACTION FUNC
    @IBAction func clearAllButtonPressed() {
        
        let alertView = UIAlertController(title: "Clear all", message: "Do you really want to clear all items from your cart?", preferredStyle: UIAlertControllerStyle.alert)
        alertView.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        alertView.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: { (alertAction) -> Void in
            
            self.clearCart()
            self.changeEnableAndDisablePaymentButton()
            
        }))
        
        present(alertView, animated: true, completion: nil)
    }
    
    @IBAction func paymentActionButton(_ sender: Any) {
        
        let countItem = CartManger.sharedInstance.numberOfItemsInCart()
        
        if countItem != 0 {
            
            paymentButton.isEnabled = false
            
        } else {
            
            paymentButton.isEnabled = true
            totalPrice = totaleCostsLabel.text!
            
        }
        
    }
    

}
