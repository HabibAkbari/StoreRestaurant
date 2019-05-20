//
//  ProfileTableViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 4/10/18.
//  Copyright © 2018 HabibMacBook Pro. All rights reserved.
//

import UIKit
import Firebase

class ProfileTableViewController: UITableViewController {


    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var countItemCart: UILabel!
    
    
    //MARK: - VAR
    var keyLogin : AnyObject {
        get {
            return    UserDefaults.standard.object(forKey: "keyLogin") as AnyObject
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "keyLogin")
            UserDefaults.standard.synchronize()
        }
    }
    

    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        loadDataFirbase()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        loadDataFirbase()
        
        let countItem : String = String(CartManger.sharedInstance.numberOfItemsInCart())
        
        countItemCart.text = "\(countItem)"
        
        super.viewWillAppear(animated)
        
        let backgroundImage = UIImage(named: "pexels-photo-253580.png")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = UIColor(red: 56/256, green: 58/256, blue: 58/256, alpha: 0.7)
    }
    
   
    //MARK: - IBACTION FUNC
    @IBAction func singOut(_ sender: Any) {
       
        singOut()
        
    }
    
    
    //MARK: - FUNC
    func singOut() {
        
        do {
            
            try FIRAuth.auth()?.signOut()
            keyLogin = "offLine" as AnyObject
            print("keyLogin\(keyLogin)")
            keyLogin2 = "offLine"

            self.navigationController?.popViewController(animated: true)
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
                (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
            }
            
            
        } catch let singOutError {
            print(singOutError)
            return
        }
        
    }
    
    func loadDataFirbase() {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as! [String:AnyObject]
            
            for user in users {
                
                let valueUser = user.value
                let keyUser = user.key
                
                if self.keyLogin as! String == keyUser {
                    
                    self.email.text = valueUser["email"] as! String
                    self.name.text = valueUser["name"] as! String
                    self.address.text = valueUser["address"] as! String
                    self.phoneNumber.text = valueUser["phoneNumber"] as! String
                }
                
            }
            
        })
        
    }

}
