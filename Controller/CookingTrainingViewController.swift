//
//  CookingTrainingViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/16/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase

class CookingTrainingViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var cookingTrainingTableView: UITableView!
    
    
    //MARK: - VAR
    var detailsCookingTraining : [String :  AnyObject] {
        
        get {
            return UserDefaults.standard.object(forKey: "detailsCookingTraining") as! [String :  AnyObject]
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "detailsCookingTraining")
            UserDefaults.standard.synchronize()
            
        }
    }
    var keyCookingTraining : String {
        
        get {
            return UserDefaults.standard.object(forKey: "keyCookingTraining") as! String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "keyCookingTraining")
            UserDefaults.standard.synchronize()
        }
    }
    var dictionaryNews = [String:AnyObject]()
    var databaseReference : FIRDatabaseReference?
    var arrayCooking = [[String:AnyObject]]()
    var arrayKeyCookingTraining = [String]()
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.navigationController?.navigationBar.transparentNavigationBar()
        
        loadDataFirbase()
        
    }

    
    //MARK: - FUNC
    func numberOfSections(in tableView: UITableView) -> Int {
        
     return   1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     return   arrayCooking.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCooking") as! CookingTrainingTableViewCell
        cell.updateCell(cookingTraining: arrayCooking[indexPath.row] as [String : AnyObject])
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        detailsCookingTraining = arrayCooking[indexPath.row] as! [String : AnyObject]
        keyCookingTraining = arrayKeyCookingTraining[indexPath.row]  as! String
        
    }
    
    func loadDataFirbase() {
        
        if dictionaryNews.isEmpty {
            
            databaseReference = FIRDatabase.database().reference()
            databaseReference?.child("cookingTraining").observeSingleEvent(of: .value, with: { (snapshot) in
                
                self.dictionaryNews = snapshot.value as! [String:AnyObject]
                
                for cooking in self.dictionaryNews {
                    
                    self.arrayKeyCookingTraining.append(cooking.key as String)
                    let valueCooking = cooking.value
                    self.arrayCooking.append(valueCooking as! [String : AnyObject])
                    self.cookingTrainingTableView.reloadData()
                    
                }
                
            })
            
        }
    }

}
