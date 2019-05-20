//
//  SignUpViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 12/17/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import SkyFloatingLabelTextField

class SignUpViewController: UIViewController, UITextFieldDelegate {


    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var emailTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var scrollScrollView: UIScrollView!
    
    
    //MARK: - LET  & VAR
    let lightGreyColor : UIColor = UIColor(red: 197 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    let darkGreyColor : UIColor = UIColor.white
    let overcastBlueColor : UIColor = UIColor(red: 0, green: 187 / 255, blue: 204 / 255, alpha: 1.0)
    var textFileds : [SkyFloatingLabelTextField] = []


    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        scrollScrollView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        textFileds = [emailTextView, passwordTextView, confirmPasswordTextView]
        
        setupUser()
        
        for textField in textFileds {
            textField.delegate = self
        }

    }
    

    //MARK: - IBACTION FUNC
    @IBAction func singUp(_ sender: Any) {
        
        if  chackeEmptiyTextFiled() {
            
            singUpToRestaurant()
            
        } else {
            
            
            let alert: UIAlertController = UIAlertController(title: "Message", message: "Not complite filed", preferredStyle: .alert)
            
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) -> Void in
                
                return
            })
            
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func validateEmail() {
        
        validateEmailTextFieldWithText(email: emailTextView.text)
        
    }
    
    @IBAction func validatePassword() {
        
        validatePasswordTextFieldWithText(password: passwordTextView.text)
        
    }
    
    @IBAction func validateConfirmPassword() {
        
        validateConfirmPasswordTextFieldWithText(password: passwordTextView.text, confirmPassword: confirmPasswordTextView.text)
        
    }
   
    
    
    //MARK: - PRIVATE FUNC
    private func registerUserIntoDatabase(_ uid: String, values: [String: AnyObject]) {
        
        let ref = FIRDatabase.database().reference()
        let usersReference = ref.child("users").child(uid)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (errorUpdate, ref) in
            
            if errorUpdate != nil {
                
                return
            }
            
            FIRAuth.auth()?.signIn(withEmail: self.emailTextView.text!, password: self.passwordTextView.text!, completion: { (user:FIRUser?, errorSignIn) in
                
                if errorSignIn != nil {
                    
                    return
                    
                } else {
                    
                    let ref = FIRDatabase.database().reference()
                    let key = ref.child("users").child((user?.uid)!).key
                    
                    keyLogin = key as AnyObject
                    
                    self.emailTextView.text = ""
                    self.passwordTextView.text = ""
                    self.confirmPasswordTextView.text = ""
                    
                    self.performSegue(withIdentifier: "singUp", sender: self)
                    self.tabBarController?.tabBar.tintColor = UIColor.green
                    
                    
                }
            })
        })
        
        
    }
    
    
    //MARK: - FUNC
    func singUpToRestaurant() {
        
        FIRAuth.auth()?.createUser(withEmail: emailTextView.text!, password: passwordTextView.text!, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                
                return
                
            } else {
                
                guard let uid = user?.uid else { return }
                let values = ["email": self.emailTextView.text!, "password": self.passwordTextView.text!, "name":"name","phoneNumber":"phoneNumber","address":"address","latitude":35.6997795542397,"longitude":51.3379191807295] as [String:Any]
                
                self.registerUserIntoDatabase(uid, values: values as [String : AnyObject])
                
            }
            
        })
        
    }
    
    func setupUser() {
        
        
        emailTextView.placeholder = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected email for traveler name field"
        )
        emailTextView.selectedTitle = NSLocalizedString(
            "Email",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for traveler name field"
        )
        emailTextView.title = NSLocalizedString(
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
        
        
        
        confirmPasswordTextView.placeholder = NSLocalizedString(
            "Confirm Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        confirmPasswordTextView.selectedTitle = NSLocalizedString(
            "Confirm Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        confirmPasswordTextView.title = NSLocalizedString(
            "Confirm Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        
        
        applySkyscannerTheme(textFiled: emailTextView)
        applySkyscannerTheme(textFiled: passwordTextView)
        applySkyscannerTheme(textFiled: confirmPasswordTextView)
        
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
    
    func chackeEmptiyTextFiled() -> Bool {
        
        if  emailTextView.text != nil && emailTextView.errorMessage == nil &&
            
            passwordTextView.text != "" && passwordTextView.errorMessage == nil &&
            confirmPasswordTextView.text != "" && confirmPasswordTextView.errorMessage == nil {
            
            return true
            
        } else {
            
            return false
        }
    }
    
    
    
    func validateEmailTextFieldWithText(email: String?) {

        guard let email = email else {
            emailTextView.errorMessage = nil
            return
        }

        if email.isEmpty {
            emailTextView.errorMessage = nil
        } else if !validateEmail(email) {

            emailTextView.errorMessage = NSLocalizedString(
                "Email not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            emailTextView.errorMessage = nil
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
    
    func validateConfirmPasswordTextFieldWithText(password: String?, confirmPassword: String?) {
        
        guard let confirmPassword = confirmPassword else {
            confirmPasswordTextView.errorMessage = nil
            return
        }
        
        if confirmPassword.isEmpty {
            confirmPasswordTextView.errorMessage = nil
        } else if validateConfirmPassword(password!, confirmPassword: confirmPassword) {
            confirmPasswordTextView.errorMessage = NSLocalizedString(
                "Confirm Password not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            confirmPasswordTextView.errorMessage = nil
        }
    }
    
    func validateEmail(_ candidate: String) -> Bool {
        
        let emailRegex =  "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    func validateName(_ candidate: String) -> Bool {

        let nameRegex = "[A-Za-z ]+"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        
    }
    
    func validatePhoneNumber(_ candidate: String) -> Bool {
        
        let phoneNumberRegex = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: candidate)
        
    }
    
    func validateZipCode(_ candidate: String) -> Bool {

        let zipCodeRegex = "^[0-9]{5}(?:-[0-9]{4})?$"
        return NSPredicate(format: "SELF MATCHES %@", zipCodeRegex).evaluate(with: candidate)
        
    }
    
    func validatePassword(_ candidate: String) -> Bool {

        let passwordRegex = "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z]).{8}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: candidate)
    }
    
    func validateConfirmPassword(_ password: String, confirmPassword: String) -> Bool {
        
        if password != confirmPassword {
            return true
        } else {
            return false
        }
    }
    

}
