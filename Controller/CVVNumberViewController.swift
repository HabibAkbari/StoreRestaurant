//
//  CVVNumberViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 6/1/18.
//  Copyright © 2018 HabibMacBook Pro. All rights reserved.
//

import UIKit

class CVVNumberViewController: UIViewController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var visaBackView: UIView!
    @IBOutlet weak var cvvTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var scrollingScrollView: UIScrollView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    //MARK: - LET & VAR
    var totalPrice : String {
        
        get {
            return UserDefaults.standard.object(forKey: "totalPrice") as! String
        }
    }
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        visaBackView.updateView()
        cvvTextField.updateTextField(countCharactersTextField: 3)
        backButton()
        
        totalLabel.text = totalPrice
        scrollingScrollView.scrolling()

        activity()
        
    }
    
    
    //MARK: - FUNC
    func backButton() {
        
        let backButoon = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        backButoon.setTitle("❮", for: .normal)
        backButoon.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButoon.addTarget(self, action: #selector(backToAddValidCCViewControllerNavigation), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButoon)
        
    }
    
    func activity() {
        
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
        
    }

    
    //MARK: - OBJC FUNC
    @objc func backToAddValidCCViewControllerNavigation() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    
    //MARK: - IBACTION FUNC
    @IBAction func sendToBankTextField(_ sender: Any) {
        
        if cvvTextField.text?.count == 3 {
            
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            
        }
    }
    
}
