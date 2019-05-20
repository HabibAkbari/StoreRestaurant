//
//  ForgotPasswordViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 12/19/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    
    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var enterPassword: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var scrollerScrollView: UIScrollView!
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        super.viewDidLoad()

        changeTextView()
        
    }

    
    //MARK: - FUNC
    func changeTextView() {
        enterPassword.underlinedTextView()
        enterPassword.attributedPlaceholder = NSAttributedString(string: "Enter password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white ])
        enterPassword.isSecureTextEntry = true
        sendButton.layer.cornerRadius = 5
        scrollerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }

}
