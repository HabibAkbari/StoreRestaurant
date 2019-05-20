//
//  ChangePasswordViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 3/5/19.
//  Copyright © 2019 HabibMacBook Pro. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePasswordViewController: UIViewController {

    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var oldPasswordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var newPasswordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var confirmNewPasswordTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var scrollScrollView: UIScrollView!
    
    
    //MARK: - LET & VAR
    var textFileds : [SkyFloatingLabelTextField] = []
    let lightGreyColor : UIColor = UIColor(red: 197 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    let darkGreyColor : UIColor = UIColor.white
    let overcastBlueColor : UIColor = UIColor(red: 0, green: 187 / 255, blue: 204 / 255, alpha: 1.0)
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        super.viewDidLoad()

        textFileds = [oldPasswordTextView, newPasswordTextView, confirmNewPasswordTextView]
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - IBACTION FUNC
    @IBAction func validateOldPassword() {
        
        validateOldPasswordTextFieldWithText(oldPassword: oldPasswordTextView.text)
    }
    
    @IBAction func validateNewPassword() {
        
        validateNewPasswordTextFieldWithText(newPassword: newPasswordTextView.text)
    }

    @IBAction func validateNewConfirmPassword() {
        
        validateConfirmNewPasswordTextFieldWithText(newPassword: newPasswordTextView.text, confirmNewPassword: confirmNewPasswordTextView.text)
    }
    
    
    //MARK: - FUNC
    func changeViewTextAndButton()  {
        
        oldPasswordTextView.underlinedTextView()
        oldPasswordTextView.attributedPlaceholder = NSAttributedString(string: "Old Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        newPasswordTextView.underlinedTextView()
        newPasswordTextView.attributedPlaceholder = NSAttributedString(string: "New Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        
        confirmNewPasswordTextView.underlinedTextView()
        confirmNewPasswordTextView.attributedPlaceholder = NSAttributedString(string: "Confirm Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        changePasswordButton.layer.cornerRadius = 5
        scrollScrollView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        
    }
    
    func setupUser() {
        
        
        oldPasswordTextView.placeholder = NSLocalizedString(
            "Old Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        oldPasswordTextView.selectedTitle = NSLocalizedString(
            "Old Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        oldPasswordTextView.title = NSLocalizedString(
            "Old Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        
        
        
        newPasswordTextView.placeholder = NSLocalizedString(
            "New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        newPasswordTextView.selectedTitle = NSLocalizedString(
            "New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        newPasswordTextView.title = NSLocalizedString(
            "New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Password for person password field"
        )
        
        
        
        
        confirmNewPasswordTextView.placeholder = NSLocalizedString(
            "Confirm New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        confirmNewPasswordTextView.selectedTitle = NSLocalizedString(
            "Confirm New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        confirmNewPasswordTextView.title = NSLocalizedString(
            "Confirm New Password",
            tableName: "SkyFloatingLabelTextField",
            comment: "Confirm password for person confirm password field"
        )
        
        
        
        applySkyscannerTheme(textFiled: oldPasswordTextView)
        applySkyscannerTheme(textFiled: newPasswordTextView)
        applySkyscannerTheme(textFiled: confirmNewPasswordTextView)
        
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

    
    func validateOldPasswordTextFieldWithText(oldPassword: String?) {
        
        guard let password = oldPassword else {
            
            oldPasswordTextView.errorMessage = nil
            return
        }
        
        if password.isEmpty {
            oldPasswordTextView.errorMessage = nil
        } else if !validatePassword(password) {
            oldPasswordTextView.errorMessage = NSLocalizedString(
                "Password not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            oldPasswordTextView.errorMessage = nil
        }
    }
    
    func validateNewPasswordTextFieldWithText(newPassword: String?) {
        
        guard let password = newPassword else {
            
            newPasswordTextView.errorMessage = nil
            return
        }
        
        if password.isEmpty {
            newPasswordTextView.errorMessage = nil
        } else if !validatePassword(password) {
            newPasswordTextView.errorMessage = NSLocalizedString(
                "Password not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            newPasswordTextView.errorMessage = nil
        }
    }
    
    func validateConfirmNewPasswordTextFieldWithText(newPassword: String?, confirmNewPassword: String?) {
        
        guard let confirmPassword = confirmNewPassword else {
            confirmNewPasswordTextView.errorMessage = nil
            return
        }
        
        if confirmPassword.isEmpty {
            confirmNewPasswordTextView.errorMessage = nil
        } else if validateConfirmPassword(newPassword!, confirmPassword: confirmPassword) {
            confirmNewPasswordTextView.errorMessage = NSLocalizedString(
                "Confirm New Password not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " "
            )
        } else {
            confirmNewPasswordTextView.errorMessage = nil
        }
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
