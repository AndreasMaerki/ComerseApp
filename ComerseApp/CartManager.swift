//
//  CartManager.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import UIKit

class CartManager: NSObject {
    
    
    var productsArray = [Product]()
    
    // singleton
    class var sharedInstance: CartManager
    {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: CartManager? = nil
        }
        dispatch_once(&Static.onceToken)
            {
                Static.instance = CartManager()
        }
        return Static.instance!
    }
    
    
    func addProduct(product: Product) {
        productsArray.append(product)
    }
    
    func removeProduct(product: Product) -> Bool
    {
        if let index = productsArray.indexOf(product)
        {
            productsArray.removeAtIndex(index)
            return true
        }
        return false
    }
    
    func clearCart() {
        productsArray.removeAll(keepCapacity: false)
    }
    
    
    func numberOfItemsInCart() -> Int
    {
        return productsArray.count
    }
    
    func totalPriceInCart() -> Double
    {
        var totalPrice: Double = 0
        for product in productsArray
        {
            totalPrice += product.price
        }
        return totalPrice
    }
    
    
    func productAtIndexPath(indexPath: NSIndexPath) -> Product {
        return productsArray[indexPath.row]
    }
    
}
