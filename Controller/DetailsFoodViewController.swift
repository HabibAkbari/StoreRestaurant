//
//  DetailsFoodViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class DetailsFoodViewController: UIViewController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var foodImage: UIImageView!
    @IBOutlet var titleFoodLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var descriptionFoodTextView: UITextView!
    @IBOutlet var addToCartButton: UIButton!
    @IBOutlet var scroller: UIScrollView!
    
    //MARK: - VAR
    var selectedTitleDetailsFood : AnyObject {
        get {
            return UserDefaults.standard.object(forKey: "selectedTitleDetailsFood") as AnyObject
        }
    }
    var selectedDetailsFood : AnyObject {
        get {
            return UserDefaults.standard.object(forKey: "selectedDetailsFood") as AnyObject
        }
    }
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        changeUI()
        updateUI()
        addBackButton()

    }
    
    override func viewWillLayoutSubviews() {
        
        self.scroller.frame = self.view.bounds
        self.scroller.contentSize.height = 400
        self.scroller.contentSize.width = 0
        
    }

    
    //MARK: - FUNC
    func changeUI() {
        
        self.navigationController?.navigationBar.transparentNavigationBar()
        scroller.contentInset = UIEdgeInsetsMake(0, 0, 400, 0)
        addToCartButton.layer.cornerRadius = 5

    }
    
    func updateUI() {

        titleFoodLabel.text = String( describing: selectedTitleDetailsFood)
        priceLabel.text = productPriceFormatter.string(from: NSNumber(value: selectedDetailsFood["price"] as! Float))
        
        let url = NSURL(string: "\(selectedDetailsFood["image"] as! String )")!
        let data = NSData(contentsOf: url as URL)
        foodImage.image = UIImage(data: data as! Data)
        descriptionFoodTextView.text = selectedDetailsFood["description"] as! String
    }
    
    func addBackButton() {
        
        let backButoon = UIButton(frame: CGRect(x: 0, y: 0, width: 40, height: 30))
        backButoon.setTitle(" ❮ ", for: .normal)
        backButoon.titleLabel?.font = UIFont(name: "Helvetica", size: 25)
        backButoon.tintColor = UIColor.white
        backButoon.backgroundColor = UIColor(red: 35/256, green: 38/256, blue: 86/256, alpha: 0.5)
        backButoon.layer.cornerRadius = backButoon.frame.width / 2
        backButoon.clipsToBounds = true
        backButoon.addTarget(self, action: #selector(tapResetButton), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButoon)
        
    }
    
    func addToCart() {
        
        let price = String( describing: selectedDetailsFood["price"] as! Float)
        let numberFormatter = NumberFormatter()
        let priceFormatter = numberFormatter.number(from: price)
        let priceFormatterFloatValue = priceFormatter?.floatValue
        
        let foods = ProductObject(title: (selectedTitleDetailsFood as! String), id:String(describing: (selectedDetailsFood["id"]!)!), price: priceFormatterFloatValue!,totle:calculatPriceItem(price: priceFormatterFloatValue!,indexPathRow: 0) ,count:1,  image: selectedDetailsFood["image"] as! String, description: selectedDetailsFood["description"] as! String, rating: selectedDetailsFood["rating" ] as! Float)
        
        let cartManger = CartManger()
        cartManger.addProduct(product: foods)
        
    }


    //MARK: - OBJC FUNC
    @objc func tapResetButton() {
        
        self.navigationController?.navigationBar.transparentNavigationBar()

        // back to root
        _ = self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //MARK: - IBACTION FUNC
    @IBAction func addToCart(_ sender: Any) {
        
        addToCart()
        
        self.navigationController?.navigationBar.transparentNavigationBar()
        
        tabBarController?.tabBar.items?[2].badgeValue = "\(buyArray.count)"
        self.navigationController?.popToRootViewController(animated: true)
    }
    

}
