//
//  FoodsCategoriseCollectionViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/4/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import FirebaseDatabase

class FoodsCategoriseCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var scroller: UIScrollView!
    
    
    //MARK: - VAR
    var categoryName : AnyObject{
        get {
            return UserDefaults.standard.object(forKey: "categoryName") as AnyObject
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "categoryName")
            UserDefaults.standard.synchronize()
        }
    }
    var foodsCategorySelected : AnyObject {
      
        get {
            return UserDefaults.standard.object(forKey: "foodsCategorySelected") as AnyObject
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "foodsCategorySelected")
            UserDefaults.standard.synchronize()
        }
    }
    var firDatabaseReference : FIRDatabaseReference?
    var dictionaryFoods = [String:AnyObject]()
    var arrayCategoryFoods = [String]()
    var arrayCategoryImageFoods = [String]()
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        scroller.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        loadDataFirbase()
        self.navigationController?.navigationBar.transparentNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    
    //MARK: - FUNC
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrayCategoryFoods.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! FoodsCategoriseCollectionViewCell
        cell.categoriseImage.layer.cornerRadius = 5
        cell.groupCellView.layer.cornerRadius = 5
        cell.configCell(imageCategory: arrayCategoryImageFoods[indexPath.row], titleCategory: arrayCategoryFoods[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        categoryName = arrayCategoryFoods[indexPath.row] as AnyObject
        
        selectCatgory(foodRow: categoryName as! String)
        
    }
    
    func loadDataFirbase() {
        
        if arrayCategoryFoods.isEmpty {
            
            firDatabaseReference = FIRDatabase.database().reference()
            firDatabaseReference?.child("foods").observeSingleEvent(of: .value, with: { (snapshot) in
                self.dictionaryFoods = snapshot.value as! [String:AnyObject]
                
                for foods in self.dictionaryFoods {
                    let valueFoods = foods.value
                    for categoryFoods in valueFoods as! [String:AnyObject]{
                        self.arrayCategoryImageFoods.append(categoryFoods.value["imageCategory"] as! String)
                        self.arrayCategoryFoods.append(categoryFoods.key as String)
                        self.categoryCollectionView.reloadData()
                    }
                }
                
            })
            
        }
    }
    
    func selectCatgory (foodRow:String) {
        
        for food in self.dictionaryFoods {
            
            let keyFood = food.value
            for catFood in keyFood as! [String:AnyObject]{
                
                self.arrayCategoryFoods.append(catFood.key as String)
                
                let catfood = catFood.key
                if catfood == foodRow {
                    foodsCategorySelected = catFood.value
                }
                
            }
            
        }
        
    }
    
}

