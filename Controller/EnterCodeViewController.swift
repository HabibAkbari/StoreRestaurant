//
//  EnterCodeViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 12/18/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class EnterCodeViewController: UIViewController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var passwordTextView: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var scrollerScrollView: UIScrollView!
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        changeTextView()
        
    }
    
    
    //MARK: - FUNC
    func changeTextView() {
        
        passwordTextView.underlinedTextView()
        passwordTextView.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextView.isSecureTextEntry = true
        scrollerScrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }

}
