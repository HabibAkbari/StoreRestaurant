//
//  SignInViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 12/14/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Firebase

extension UITextField {
    
    func underlinedTextView() {
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
        
    }
}

class SignInViewController: UIViewController, UITextFieldDelegate{


    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var emailTextview: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var scrollingScrollView: UIScrollView!
    
    
    //MARK: - LET  & VAR
    var textFileds : [SkyFloatingLabelTextField] = []
    let lightGreyColor : UIColor = UIColor(red: 197 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    let darkGreyColor : UIColor = UIColor.white
    let overcastBlueColor : UIColor = UIColor(red: 0, green: 187 / 255, blue: 204 / 255, alpha: 1.0)
    

    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        changeViewTextView()
        textFileds = [emailTextview, passwordTextView]

        setupUser()
        
        for textField in textFileds {
            textField.delegate = self
        }
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBACTION FUNC
    @IBAction func singIn(_ sender: Any) {
        
        singIn(email: emailTextview.text!, password: passwordTextView.text!)
        
    }
    
    @IBAction func validateEmail() {
        
        validateEmailTextFieldWithText(email: emailTextview.text)
        
    }
    
    @IBAction func validatePassword() {
        
        validatePasswordTextFieldWithText(password: passwordTextView.text)
        
    }

    
    //MARK: - FUNC
    func setupUser() {
        
        
        emailTextview.placeholder = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected email for traveler name field"
        )
        emailTextview.selectedTitle = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for traveler name field"
        )
        emailTextview.title = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for traveler name field"
        )
        
        

        passwordTextView.placeholder = NSLocalizedString(
            "Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        passwordTextView.selectedTitle = NSLocalizedString(
            "Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        passwordTextView.title = NSLocalizedString(
            "Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        
        
        applySkyscannerTheme(textFiled: emailTextview)
        applySkyscannerTheme(textFiled: passwordTextView)
        
        
    }
    
    func applySkyscannerTheme(textFiled: SkyFloatingLabelTextField) {
        
        textFiled.tintColor = overcastBlueColor
        textFiled.textColor = darkGreyColor
        textFiled.lineColor = lightGreyColor
        
        textFiled.selectedTitleColor = overcastBlueColor
        textFiled.selectedLineColor = overcastBlueColor
        
        textFiled.titleLabel.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 12)
        textFiled.placeholderFont = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        textFiled.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 18)
        
    }
    
    func changeViewTextView() {
        
        signInButton.layer.cornerRadius = 5
        facebookButton.layer.cornerRadius = 5
        twitterButton.layer.cornerRadius = 5
        
        scrollingScrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
    }
    
    func singIn(email:String , password: String)  {
    
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user:FIRUser?, error) in
            
            if let error = error {
                
                print(error)
                return
                
            } else {
                
                
                let ref = FIRDatabase.database().reference()
                let key = ref.child("users").child((user?.uid)!).key
                
                keyLogin = key as AnyObject
                keyLogin2 = key
                print(keyLogin2)
                
                
                self.emailTextview.text = ""
                self.passwordTextView.text = ""
                
                self.performSegue(withIdentifier: "singIn", sender: self)
                self.tabBarController?.tabBar.tintColor = UIColor.green
                
                return
            }
        })
        
    }
    
    

    func validateEmailTextFieldWithText(email: String?) {
        
        guard let email = email else {
            
            emailTextview.errorMessage = nil
            return
            
        }
        
        if email.isEmpty {
            
            emailTextview.errorMessage = nil
            
        } else if !validateEmail(email) {
            
            emailTextview.errorMessage = NSLocalizedString(
                "Email not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
            
        } else {
            
            emailTextview.errorMessage = nil
            
        }
    }
    
    func validatePasswordTextFieldWithText(password: String?) {
        
        guard let password = password else {
            
            passwordTextView.errorMessage = nil
            return
        }
        
        if password.isEmpty {
            
            passwordTextView.errorMessage = nil
            
        } else if !validatePassword(password) {
            
            passwordTextView.errorMessage = NSLocalizedString(
                "Password not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
            
        } else {
            
            passwordTextView.errorMessage = nil
        }
    }
    
    func validateEmail(_ candidate: String) -> Bool {
        
        let emailRegex =  "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
        
    }
    
    func validatePassword(_ candidate: String) -> Bool {
        
        let passwordRegex = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z]).{8}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
        
    }
    
}
