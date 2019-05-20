//
//  CookingTrainingDetailsTableViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/20/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import Cosmos
import FirebaseDatabase

class CookingTrainingDetailsTableViewController: UITableViewController {
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet var cookingTrainingDetailsImage: UIImageView!
    @IBOutlet var titleCookingTrainingLabel: UILabel!
    @IBOutlet var descriptionCookingTrainingLabel: UILabel!
    @IBOutlet var cookingTrainingTableView: UITableView!
    @IBOutlet var tableViewCellMethod: UITableViewCell!
    @IBOutlet weak var methodCookingTrainingTextView: UITextView!
    @IBOutlet weak var ingredientsCookingTrainingTextView: UITextView!
    @IBOutlet weak var cookingTrainingRatingView: CosmosView!
    
    
    //MARK: - LET  & VAR
    var detailsCookingTraining : [String :  AnyObject] {
        
        get {
            
            return UserDefaults.standard.object(forKey: "detailsCookingTraining") as! [String : AnyObject]
        }
        
    }
    var keyCookingTraining : String {
        
        get {
            return UserDefaults.standard.object(forKey: "keyCookingTraining") as! String
        }
    }
    var array = [String]()
    var methodArray = [String]()
    var databaseReference : FIRDatabaseReference?
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // table View scrolling up
        cookingTrainingTableView.contentInset = UIEdgeInsetsMake(-88, 0, 0, 0)
        
        updateDetailsCookingTRainingTableView()
        
        uiNavgtion()
        
        setBackgroundTableView()
        
        rating()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return  detailsCookingTraining.count
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor(red: 31/255, green: 35/255, blue: 46/255, alpha: 1.0)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        
    }
    
    
    //MARK: - FUNC
    func uiNavgtion() {
        
        self.navigationController?.navigationBar.transparentNavigationBar()
        
        let backButton = UIBarButtonItem(title: " ", style: UIBarButtonItemStyle.plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        
    }
    
    func rating() {
        
        cookingTrainingRatingView.didTouchCosmos = { rating in
            
            let rating = self.cookingTrainingRatingView.rating
            self.databaseReference = FIRDatabase.database().reference()
            self.databaseReference?.child("cookingTraining").child(self.keyCookingTraining).updateChildValues(["rate":rating])
            
        }
        
    }
    
    func setBackgroundTableView() {
        
        // set image background Table View Static
        let backgroundImage = UIImage(named: "background_classic_Home_black.png")
        let imageView = UIImageView(image: backgroundImage)
        cookingTrainingTableView.backgroundView = imageView
        
    }
    
    func updateDetailsCookingTRainingTableView() {
        
        let url = NSURL(string: "\(detailsCookingTraining["image"] as! String)")
        let data = NSData(contentsOf: url! as URL)
        cookingTrainingDetailsImage.image = UIImage(data: data! as Data)
        
        titleCookingTrainingLabel.text = detailsCookingTraining["title"] as? String
        descriptionCookingTrainingLabel.text = detailsCookingTraining["discription"] as? String
        descriptionCookingTrainingLabel.textAlignment = .justified
        
        let ingredients = detailsCookingTraining["ingredients"] as! [String:String]
        for item in ingredients {
            array.append("✓ \(item.value)")
        }

        ingredientsCookingTrainingTextView.text = array.joined(separator: "\n")
        let methods = detailsCookingTraining["method"] as! [String : String]
        for method in methods {
            methodArray.append("\(method.key.capitalized) : \( method.value)")
        }

        methodCookingTrainingTextView.text = methodArray.joined(separator: "\n")
        cookingTrainingRatingView.rating = detailsCookingTraining["rate"] as! Double
        
    }
    
}
