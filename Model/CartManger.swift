//
//  CartManger.swift
//  StoreRestaurant
//
//  Created by Habib Akbari on 10/5/17.
//  Copyright © 2017 HabibMacBook Pro. All rights reserved.
//

import UIKit

class CartManger: NSObject {
    
    
    //MARK: - CLASS VAR
    class var sharedInstance : CartManger {
        
        struct Static {
            static let instance : CartManger = CartManger()
        }
        return Static.instance
    }
    
    
    
    //MARK: - FUNC
    // Add a product to the Cart
    func addProduct(product: ProductObject) {
        
        buyArray.append(product)
        
    }
    
    // Remove a product to the Cart
    func removeProduct(product: ProductObject) -> Bool {
        
        if let index = buyArray.index(where: {$0 === product}) {
            buyArray.remove(at: index)
            return true
        }
        return false
    }
    
    // Remove all product from the Cart
    func clearCart() {
        
        buyArray.removeAll(keepingCapacity: false)
    }
    
    // Number Of Producrs in the Cart
    func numberOfItemsInCart() -> Int {
        
        return buyArray.count
    }
    
    // Total price of the products in the Cart
    func totalPriceInCart() -> Float {
        
        var totalPrice : Float = 0
        for product in buyArray {
            totalPrice += product.totalPrice()
        }
        return totalPrice
    }
    
    // And one convenience function to get a Product at a given indexPath
    func productAtIndexPath(indexPath: NSIndexPath) -> ProductObject {
        
        return buyArray[indexPath.row]
    }


}
