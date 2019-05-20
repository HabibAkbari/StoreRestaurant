//
//  FoodsTableViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class FoodsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //MARK: - VAR
    var categoryName : AnyObject {
      
        get {
            return UserDefaults.standard.object(forKey: "categoryName") as AnyObject
        }
    }
    var foodsCategorySelected : AnyObject {
        
        get {
            return UserDefaults.standard.object(forKey: "foodsCategorySelected") as AnyObject
        }
        
    }
    var selectedDetailsFood : AnyObject {
        
        get {
            return UserDefaults.standard.object(forKey: "selectedDetailsFood") as AnyObject
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedDetailsFood")
            UserDefaults.standard.synchronize()
        }
        
    }
    var selectedTitleDetailsFood : AnyObject {
        
        get {
            return UserDefaults.standard.object(forKey: "selectedTitleDetailsFood") as AnyObject
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTitleDetailsFood")
            UserDefaults.standard.synchronize()
        }
        
    }
    var titleFoodArray = [String]()
    var detialsFoodArray = [[String:AnyObject]]()

    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        let uppercasedTitle = categoryName.capitalized
        self.navigationItem.title = uppercasedTitle
        
        let selectedFood = foodsCategorySelected as! [String:AnyObject]
        for food in selectedFood {
           
            if food.key != "imageCategory" {
                
                self.titleFoodArray.append(food.key)

                let details = food.value as! [String:AnyObject]
                detialsFoodArray.append(details)
                
            }

        }
        
        addSettingButtonLeft()
        
    }
    
    
    //MARK: - FUNC
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titleFoodArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "foodsCell", for: indexPath) as! FoodsTableViewCell
        cell.configCell(foodsTitles: [titleFoodArray[indexPath.row]], foodsDetails: detialsFoodArray[indexPath.row] as [String:AnyObject])
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTitleDetailsFood = titleFoodArray[indexPath.row] as AnyObject
        selectedDetailsFood = detialsFoodArray[indexPath.row] as AnyObject
        
    }
    
    func addSettingButtonLeft() {
        
        let button = UIButton(type: .custom)
        button.setBackgroundImage(UIImage(named: "category"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(categoryBar), for: UIControlEvents.touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = barButton
    }
    

    //MARK: - OBJC FUNC
    @objc func categoryBar() {
        
       let _ = self.navigationController?.popToRootViewController(animated: true)
        
    }
  

}
