//
//  AccountViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 12/17/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var scrollerScrollView: UIScrollView!
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        signInButtonUI()
        scrollerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.transparentNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        
        if keyLogin as! String != "offLine" {
           
            FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
                
                if let user = user {
                    self.performSegue(withIdentifier: "singIn", sender: self)
                    
                } else {
                    return
                }
                
            })
        } 
        
        
    }

    
    //MARK: - FUNC
    func signInButtonUI() {
        
        signInButton.layer.cornerRadius = 5
        signUpButton.layer.cornerRadius = 5
        
    }


}
