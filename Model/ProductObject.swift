//
//  ProductObject.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/5/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import Foundation

class ProductObject {
    
    //MARK: - FILEPRIVATE VAR
    fileprivate var titleFoods : String!
    fileprivate var idFoods : String!
    fileprivate var priceFoods : Float!
    fileprivate var totleFood : Float!
    fileprivate var countItemFood : Int!
    fileprivate var imageFoods : String!
    fileprivate var descriptionFoods :String!
    fileprivate var ratingFoods : Float!
    
    
    //MARK: - VAR
    var title : String {
        
        get {
            if titleFoods == nil {
                return ""
            }
            return titleFoods
        }
        
    }
    
    var id : String {
        
        get {
            if idFoods == nil {
                return ""
            }
            return idFoods
        }
    }
    
    var price : Float {
        
        get {
            if priceFoods == 0.0 {
                return  priceFoods
            }
            return priceFoods
        }
        
        set {
            priceFoods = newValue
        }
    }
    
    var totle : Float {
        
        get {
            if totleFood == 0.0 {
                return totleFood
            }
            return totleFood
        }
        set {
            totleFood = newValue
        }
    }
    
    var count : Int {
        
        get {
            if countItemFood == 0 {
                return 1
            }
            return countItemFood
        }
        set {
            countItemFood = newValue
        }
    }
    
    var image : String {
        
        get {
            if imageFoods == nil {
                return ""
            }
            return imageFoods
        }
    }
    
    var description : String {
        
        get {
            if descriptionFoods == nil {
                return ""
            }
            return descriptionFoods
        }
    }
    
    var rating : Float {
        
        get {
            if ratingFoods == nil {
                return 0.0
            }
            return ratingFoods
        }
    }
    
    
    //MARK: - INIT
    init(title:String, id: String, price: Float, totle: Float,count: Int, image: String, description: String, rating: Float) {
        
        titleFoods = title
        idFoods = id
        priceFoods = price
        totleFood = totle
        countItemFood = count
        imageFoods = image
        descriptionFoods = description
        ratingFoods = rating
        
    }
    
    
    //MARK: - FUNC
    func totalPrice() -> Float {
        
        var sum = Float()
        
        if count != 1 {
            
            sum += totleFood!
            
        } else {
            
            sum += priceFoods!
            
        }
        
        return sum
    }
    
    
}
