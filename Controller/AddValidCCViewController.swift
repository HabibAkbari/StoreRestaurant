//
//  AddValidCCViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 5/27/18.
//  Copyright © 2018 HabibMacBook Pro. All rights reserved.
//

import UIKit

//MARK: EXTENSION
extension UIView {

    func updateView() {
        
        // Shadow
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.5
        layer.shadowColor = UIColor.black.cgColor
        
        // Line Up & Left
        let borderLayer = CALayer()
        borderLayer.backgroundColor = UIColor.darkGray.cgColor
        borderLayer.frame = CGRect(x: 0 , y: 0, width: 1, height: frame.height)
        borderLayer.cornerRadius = 20
        layer.addSublayer(borderLayer)
        
        let borderUpLayer = CALayer()
        borderUpLayer.backgroundColor = UIColor.darkGray.cgColor
        borderUpLayer.frame = CGRect(x: 0, y: 0 , width: frame.width, height: 1)
        borderUpLayer.cornerRadius = 20
        layer.addSublayer(borderUpLayer)
        
        // Radius
        layer.cornerRadius = 20
        
    }
    
}
extension UITextField {
    
    func updateTextField(countCharactersTextField:Int) {
        
        let colorPlaceHolder = UIColor(red: 95/255, green: 97/255, blue: 98/255, alpha: 1.0)
        let fontPlaceHolder = UIFont(name: "OCR A Extended", size: 23)
        
        // Change color placeHolder textField
        if countCharactersTextField == 4 {
            attributedPlaceholder = NSAttributedString(string: "0000", attributes: [NSAttributedStringKey.foregroundColor : colorPlaceHolder])
        } else if countCharactersTextField == 3 {
            attributedPlaceholder = NSAttributedString(string: "XXX", attributes: [NSAttributedStringKey.foregroundColor : colorPlaceHolder])
        } else {
            attributedPlaceholder = NSAttributedString(string: "00", attributes: [NSAttributedStringKey.foregroundColor : colorPlaceHolder])
        }
        
        // Change font textField
        font = fontPlaceHolder
        
        // Change color pipe textField
        tintColor = UIColor.green
        
    }
}

class AddValidCCViewController: UIViewController, UITextFieldDelegate {


    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var viewVisa: UIView!
    @IBOutlet weak var number4FirstTextField: UITextField!
    @IBOutlet weak var number4SecondTextField: UITextField!
    @IBOutlet weak var number4ThirdTextField: UITextField!
    @IBOutlet weak var number4FourthTextFiled: UITextField!
    @IBOutlet weak var numberMMTextField: UITextField!
    @IBOutlet weak var numberYYTextField: UITextField!
    @IBOutlet weak var scrollingScrollView: UIScrollView!
    @IBOutlet weak var totalLabel: UILabel!
    
    
    //MARK: - LET  & VAR
    var numberCartCombine : String = ""
    var mmYY : String = ""
    // write data for send AddValidCCViewController
    var numberCart : String {
        
        get {
            return UserDefaults.standard.object(forKey: "numberCart") as! String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "numberCart")
            UserDefaults.standard.synchronize()
        }
    }
    var mmYYCart : String {
        
        get {
            return UserDefaults.standard.object(forKey: "mmYYCart") as! String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "mmYYCart")
            UserDefaults.standard.synchronize()
        }
    }
    var totalPriceAddCCToCVV : String {
        
        get {
            return UserDefaults.standard.object(forKey: "totalPriceAddCCToCVV") as! String
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: "totalPriceAddCCToCVV")
            UserDefaults.standard.synchronize()
        }
    }
    var totalPrice : String {
      
        get {
        return UserDefaults.standard.object(forKey: "totalPrice") as! String
        }
    }
    
    
    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        
        super.viewDidLoad()

        viewVisa.updateView()
        configTextField()
        backButton()
 
        scrollingScrollView.scrolling()
        totalLabel.text = totalPrice

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        totalPriceAddCCToCVV = totalPrice
        numberCart = numberCartCombine
        mmYYCart = mmYY
    }
    
    
    //MARK: - FUNC
    func configTextField() {
        
        // delegate textField
        number4FirstTextField.delegate = self
        number4SecondTextField.delegate = self
        number4ThirdTextField.delegate = self
        number4FourthTextFiled.delegate = self
        numberMMTextField.delegate = self
        numberYYTextField.delegate = self
        
        // Update textField
        number4FirstTextField.updateTextField(countCharactersTextField: 4)
        number4SecondTextField.updateTextField(countCharactersTextField: 4)
        number4ThirdTextField.updateTextField(countCharactersTextField: 4)
        number4FourthTextFiled.updateTextField(countCharactersTextField: 4)
        numberMMTextField.updateTextField(countCharactersTextField: 2)
        numberYYTextField.updateTextField(countCharactersTextField: 2)

    }
    
    func backButton() {
        
        let backButoon = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        backButoon.setTitle("❮", for: .normal)
        backButoon.titleLabel?.font = UIFont(name: "Helvetica", size: 30)
        backButoon.addTarget(self, action: #selector(backToAddValidCCViewControllerNavigation), for: .touchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButoon)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        case number4FirstTextField:
             number4SecondTextField.becomeFirstResponder()
            
        case number4SecondTextField:
             number4ThirdTextField.becomeFirstResponder()
            
        case number4ThirdTextField:
             number4FourthTextFiled.becomeFirstResponder()
            
        case number4FourthTextFiled:
             numberMMTextField.becomeFirstResponder()
            
        case numberMMTextField:
             numberYYTextField.becomeFirstResponder()
            
        default:
            return true
        }

        return true
    }
    
    func checkEmptyTextField() -> Bool {
        
        if (number4FirstTextField.text?.isEmpty)! && (number4SecondTextField.text?.isEmpty)! && (number4ThirdTextField.text?.isEmpty)! && (number4FourthTextFiled.text?.isEmpty)! && (numberMMTextField.text?.isEmpty)! {
            return true
        } else {
            return false
        }
    }
    
    
    //MARK: - OBJC FUNC
    @objc func backToAddValidCCViewControllerNavigation() {
        
        self.navigationController?.popViewController(animated: true)
        
    }
    

    //MARK: - IBACTION FUNC
    @IBAction func jumpFrom1ot2TextField() {
        
        if number4FirstTextField.text?.count == 4 {
            
            textFieldShouldReturn(number4FirstTextField)
        }

    }
    
    @IBAction func jumpFrom2ot3TextField() {
        
        if number4SecondTextField.text?.count == 4 {
            
            textFieldShouldReturn(number4SecondTextField)
        }
    }
    
    @IBAction func jumpFrom3ot4TextField() {
        
        if number4ThirdTextField.text?.count == 4 {
            
            textFieldShouldReturn(number4ThirdTextField)
        }
    }
    
    @IBAction func jumpFrom4otMMTextField() {
        
        if number4FourthTextFiled.text?.count == 4 {
            
            textFieldShouldReturn(number4FourthTextFiled)
            numberCartCombine = number4FirstTextField.text! + number4SecondTextField.text!  + number4ThirdTextField.text! + number4FourthTextFiled.text!
        }
    }
    
    @IBAction func jumpFromYYtoViewControllerTextField() {
        
        if numberYYTextField.text?.count == 2 {
            
            self.performSegue(withIdentifier: "cvvSague", sender: self)
            mmYY = numberMMTextField.text! + numberYYTextField.text!
            
        }
        
        
    }
    
    @IBAction func jumpFromMMtoYYTextField() {
        
        if numberMMTextField.text?.count == 2 {
            
            textFieldShouldReturn(numberMMTextField)
        }
    }


}
