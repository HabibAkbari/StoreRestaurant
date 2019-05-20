//
//  EditProfileViewController.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 4/17/18.
//  Copyright © 2018 HabibMacBook Pro. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import SkyFloatingLabelTextField

class EditProfileViewController: UIViewController,UITextFieldDelegate {


    //MARK: - IBOUTLET WEAK VAR
    @IBOutlet weak var emailTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var phoneTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var addressTextView: SkyFloatingLabelTextField!
    @IBOutlet weak var localMapView: MKMapView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var scrollScrollView: UIScrollView!
    
    
    //MARK: - LET  & VAR
    var textFileds : [SkyFloatingLabelTextField] = []
    let lightGreyColor : UIColor = UIColor(red: 197 / 255, green: 205 / 255, blue: 205 / 255, alpha: 1.0)
    let darkGreyColor : UIColor = UIColor.white
    let overcastBlueColor : UIColor = UIColor(red: 0, green: 187 / 255, blue: 204 / 255, alpha: 1.0)
    var latitude = Double()
    var longitude = Double()
    var keyLogin : AnyObject {
        get {
            return    UserDefaults.standard.object(forKey: "keyLogin") as AnyObject
        }

    }
    

    //MARK: - OVERRIDE FUNC
    override func viewDidLoad() {
        super.viewDidLoad()

        print(keyLogin)
        
        scrollScrollView.contentInset = UIEdgeInsetsMake(0, 0, 200, 0)
        
        textFileds = [emailTextView, nameTextView, phoneTextView,addressTextView]
        
        configTextView()
        
        let longPressDestargest = UILongPressGestureRecognizer(target: self, action: #selector(addAnnotation(press:)))
        longPressDestargest.minimumPressDuration = 2.0
        localMapView.addGestureRecognizer(longPressDestargest)
        
        setupUser()
        
        for textField in textFileds {
            textField.delegate = self
        }
        

    }
    

    //MARK: - IBACTION FUNC
    @IBAction func validateName() {
        
        validateNameTextFieldWithText(name: nameTextView.text)
    }
    
    @IBAction func validatePhoneNumber() {
        
        validatePhoneNumberTextFieldWithText(phoneNumber: phoneTextView.text)
    }
    
    @IBAction func validateAddress() {
        
        validateAddressTextFieldWithText(address: addressTextView.text)
    }

    @IBAction func singUp(_ sender: Any) {
        
        if  chackeEmptiyTextFiled() {
            
            updateUser()
            
            
        } else {
            
            
            let alert: UIAlertController = UIAlertController(title: "Message", message: "Not complite filed", preferredStyle: .alert)
            
            let action:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (a: UIAlertAction) -> Void in
                
                return
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)

        }
        
    }
    
    
    //MARK: - OBJC FUNC
    @objc func addAnnotation(press:UILongPressGestureRecognizer) {
        
        if press.state == .began  {
            
            let location = press.location(in: localMapView)
            let coordinates = localMapView.convert(location, toCoordinateFrom: localMapView)
            let anntation = MKPointAnnotation()
            
            anntation.coordinate = coordinates
            anntation.title = "Your Address"
            anntation.subtitle = "this is my farocirit plase"
            
            latitude = coordinates.latitude
            longitude = coordinates.longitude
            
            // remove old pin for mapview
            localMapView.removeAnnotations(localMapView.annotations)
            // add new pin for mapview
            localMapView.addAnnotation(anntation)
            
        }
        
    }
    
    
    //MARK: - FUNC
    func chackeEmptiyTextFiled() -> Bool {

        if
            nameTextView.text != "" && nameTextView.errorMessage == nil &&
            phoneTextView.text != "" && phoneTextView.errorMessage == nil &&
            addressTextView.text != "" && addressTextView.errorMessage == nil {
            
            return true
        } else {
            return false
        }
    }
    
    func setupUser() {
        
        
        nameTextView.placeholder = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for traveler name field"
        )
        nameTextView.selectedTitle = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "selected title for traveler name field"
        )
        nameTextView.title = NSLocalizedString(
            "Name",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for traveler name field"
        )
        
        
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
        
        
        
        phoneTextView.placeholder = NSLocalizedString(
            "Phone Number",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for person title field"
        )
        phoneTextView.selectedTitle = NSLocalizedString(
            "Phone Number",
            tableName: "SkyFloatingLabelTextField",
            comment: "Selected title for person title field"
        )
        phoneTextView.title = NSLocalizedString(
            "Phone Number",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for person title field"
        )
        
        
        
        addressTextView.placeholder = NSLocalizedString(
            "Address",
            tableName: "SkyFloatingLabelTextField",
            comment: "placeholder for person title field"
        )
        addressTextView.selectedTitle = NSLocalizedString(
            "Address",
            tableName: "SkyFloatingLabelTextField",
            comment: "Selected title for person title field"
        )
        addressTextView.title = NSLocalizedString(
            "Address",
            tableName: "SkyFloatingLabelTextField",
            comment: "title for person title field"
        )
        
        applySkyscannerTheme(textFiled: emailTextView)
        applySkyscannerTheme(textFiled: phoneTextView)
        applySkyscannerTheme(textFiled: nameTextView)
        applySkyscannerTheme(textFiled: addressTextView)
        
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
    
    func loctionInMap(latitude:Double,longitude:Double) {
        
        let pinLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let objectAnn = MKPointAnnotation()
        
        objectAnn.coordinate = pinLocation
        objectAnn.title = "Tahran"
        objectAnn.subtitle = "Tahran"
        
        self.localMapView.addAnnotation(objectAnn)
        
        localMapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegion(center: pinLocation, span: span)
        
        localMapView.setRegion(region, animated: true)
        
    }
    
    func configTextView() {
        
        let ref = FIRDatabase.database().reference()
        
        ref.child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            let users = snapshot.value as! [String:AnyObject]
            
            for user in users {
                
                let valueUser = user.value
                let keyUser = user.key
                
                if self.keyLogin as! String == keyUser {
                    
                    self.emailTextView.text = valueUser["email"] as! String
                    self.nameTextView.text = valueUser["name"] as! String
                    self.addressTextView.text = valueUser["address"] as! String
                    self.phoneTextView.text = valueUser["phoneNumber"] as! String
                    self.latitude = valueUser["latitude"] as! Double
                    self.longitude = valueUser["longitude"] as! Double
                    self.loctionInMap(latitude: self.latitude as! Double, longitude: self.longitude as! Double)
                    
                }
                
            }
            
        })
    }
    
    func updateUser() {
        
        let ref = FIRDatabase.database().reference()
        
        let values = [
            "name": self.nameTextView.text!,
            "address": self.addressTextView.text!,
            "phoneNumber":self.phoneTextView.text!,
            "latitude":latitude,
            "longitude":longitude] as [String:Any]
        
        
        let usersReference = ref.child("users").child(keyLogin as! String)
        
        usersReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            
            if error != nil {
                
                return
            }
            
            print("successfully Added a New User to the Database")
            self.navigationController?.popViewController(animated: true)
        })
        
        
    }
    
   
    
    func validateNameTextFieldWithText(name: String?) {
        
        guard let name = name else {
            
            nameTextView.errorMessage = nil
            return
            
        }
        
        if name.isEmpty {
            nameTextView.errorMessage = nil
        } else if !validateName(name) {
            nameTextView.errorMessage = NSLocalizedString(
                "Name not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            nameTextView.errorMessage = nil
        }
    }
    
    func validatePhoneNumberTextFieldWithText(phoneNumber: String?) {
        
        guard let phoneNumber = phoneNumber else {
            phoneTextView.errorMessage = nil
            return
            
        }
        
        if  phoneNumber.isEmpty {
            phoneTextView.errorMessage = nil
        } else if !validatePhoneNumber(phoneNumber) {
            phoneTextView.errorMessage = NSLocalizedString(
                "Phone number not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            phoneTextView.errorMessage = nil
        }
    }
    
    func validateAddressTextFieldWithText(address: String?) {
        
        guard let address = address else {
            
            nameTextView.errorMessage = nil
            return
            
        }
        
        if address.isEmpty {
            nameTextView.errorMessage = nil
        } else if !validateAddress(address) {
            nameTextView.errorMessage = NSLocalizedString(
                "Address not valid",
                tableName: "SkyFloatingLabelTextField",
                comment: " ")
        } else {
            nameTextView.errorMessage = nil
        }
    }

    func validateName(_ candidate: String) -> Bool {
        
        let nameRegex = "[A-Za-z ]+"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: candidate)
        
    }
    
    func validatePhoneNumber(_ candidate: String) -> Bool {
        
        let phoneNumberRegex = "^[0-9]{10}$"
        return NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex).evaluate(with: candidate)
        
    }
    
    func validateAddress(_ candidate: String) -> Bool {
        
        let addressRegex = "[A-Za-z ]+"
        return NSPredicate(format: "SELF MATCHES %@", addressRegex).evaluate(with: candidate)
        
    }
    
    func validateZipCode(_ candidate: String) -> Bool {
        

        let zipCodeRegex = "^[0-9]{5}(?:-[0-9]{4})?$"
        return NSPredicate(format: "SELF MATCHES %@", zipCodeRegex).evaluate(with: candidate)
        
    }
   
    
}
