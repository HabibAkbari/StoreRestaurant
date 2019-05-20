//
//  Constant.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/5/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import Foundation
import UIKit

//MARK: - VAR
var cart = CartManger()
var foodsSelect : [ProductObject] = []
var buyArray : [ProductObject] = []
var countItem = 1
var totlePrice = ""
var indexPathIncres : [ProductObject] = []
var keyLogin2 = "offLine"
var keyLogin : AnyObject {

    get {
        return UserDefaults.standard.object(forKey: "keyLogin") as AnyObject
    }

    set {
        UserDefaults.standard.set(newValue, forKey: "keyLogin")
        UserDefaults.standard.synchronize()
    }
}
var productPriceFormatter : NumberFormatter = {
    let productPriceFormatter = NumberFormatter()
    productPriceFormatter.numberStyle = .currency
    productPriceFormatter.locale = NSLocale.current
    return productPriceFormatter
}()


//MARK: - STRUCT
struct User {
    
    let firstName : String
    let lastName : String
    //let age : Int
    let email : String
    let phoneNumber : String
    let zipCode : String
    
    
}



//MARK: - EXTENSION
// Valdtion
extension UITextField {
    
    func validateField(functins: [(String) -> Bool]) -> Bool {
        return functins.map { f in f(self.text ?? "") }.reduce(true) {
            $0 && $1 }
    }
}

extension String  {
    
    func eveluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else { return false }
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
}

extension UITextField: Validatable {
    
    func validate(_ functions: [(String) -> Bool]) -> Bool {
        return functions.map { f in f(self.text ?? "")}.reduce(true) {$0 && $1}
    }
    
}

extension String: Evaluatable {
    
    func evaluate(with condition: String) -> Bool {
        guard let range = range(of: condition, options: .regularExpression, range: nil, locale: nil) else { return false }
        return range.lowerBound == startIndex && range.upperBound == endIndex
    }
}

extension User: Validatable {
    
    func validate(_ functions: [(User) -> Bool]) -> Bool {
        return functions.map { f in f (self)}.reduce(true) { $0 && $1}
    }
}

// SizeScroll
extension  UIScrollView {
    func scrolling() {
        contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
    }
}



//MARK: - PROTOCOL
protocol Validatable {
    
    associatedtype T
    func validate(_ functions: [T]) -> Bool
    
}

protocol Evaluatable {
    
    associatedtype T
    func evaluate(with condition: T) -> Bool
    
}




//MARK: - FUNC
func isUserNameValid(user: User) -> Bool {
    
    let regexp = "[A-Za-z]+"
    return user.firstName.evaluate(with: regexp) && user.lastName.evaluate(with: regexp)
    
}

func isEmail(user: User) -> Bool {
    
    let regexp = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
    return user.email.evaluate(with: regexp)
}

func isPhoneNumber(user: User) -> Bool {

    let regexp = "^[0-9]{10}$"
    return user.phoneNumber.evaluate(with: regexp)

}

func isZipCode(user: User) -> Bool {

    let regexp = "^[0-9]{5}$"
    return user.zipCode.evaluate(with: regexp)

}

func isPhoneNumberValid(text: String) -> Bool {
    
    let regexp = "^[0-9]{10}$"
    return text.eveluate(with: regexp)
    
}

func isZipCodeValid(text: String) -> Bool {
    
    let regexp = "^[0-9]{5}$"
    return text.eveluate(with: regexp)
    
}

func isStateValid(text: String) -> Bool {
    
    let regexp = "^[A-Z]{2}$"
    return text.eveluate(with: regexp)
    
}

func isCVValid(text: String) -> Bool {
    
    let regexp = "^[0-9]{3,4}$"
    return text.eveluate(with: regexp)
    
}

func isEmailValid(text: String) -> Bool {
    
    let regexp = "^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$"
    return text.eveluate(with: regexp)
    
}

func calculatPriceItem(price: Float, indexPathRow:Int) -> Float {
    
    if buyArray.count == 0 {
        //var multiply = 0.0
        let multiply = Float(countItem) * price
        return multiply
    } else {
        let  multiply2 = Float(countItem) * buyArray[indexPathRow].price
        return multiply2
    }
    
    //   return multiply
}

func updateTotalConstsLabel() -> String {
    
    let total = productPriceFormatter.string(from: NSNumber(value:CartManger.sharedInstance.totalPriceInCart()))!
    totlePrice = total
    
    return totlePrice
}
