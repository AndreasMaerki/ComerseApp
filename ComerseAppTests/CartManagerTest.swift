//
//  CartManagerTest.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import XCTest

class CartManagerTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testAddProduct()
    {
        let productsToAdd = 5
        let cartMNGR = CartManager.sharedInstance
        for _ in 1...productsToAdd
        {
            let product = Product()
            cartMNGR.addProduct(product)
        }
        
        XCTAssert(cartMNGR.productsArray.count == productsToAdd, "adding products failed")
        cartMNGR.clearCart()
    }
    
    func testRemoveProduct()
    {
        let cartMNGR = CartManager.sharedInstance
        let product = Product()
        cartMNGR.addProduct(product)
        cartMNGR.removeProduct(product)
        XCTAssert(cartMNGR.productsArray.count == 0, "removing products failed")
        cartMNGR.clearCart()
    }
    
    func testTotalPriceInCart()
    {
        let productsToAdd = 5
        let price:Double = 10
        let cartMNGR = CartManager.sharedInstance
        for _ in 1...productsToAdd
        {
            let product = Product()
            product.price = price
            cartMNGR.addProduct(product)
        }
        XCTAssert(cartMNGR.totalPriceInCart() == price * Double(productsToAdd), "total price calculation failed")
        cartMNGR.clearCart()
    }
    
    func testClearCart()
    {
        let cartMNGR = CartManager.sharedInstance
        for _ in 1...50
        {
            let product = Product()
            cartMNGR.addProduct(product)
        }
        cartMNGR.clearCart()
        XCTAssert(cartMNGR.productsArray.count == 0, "ClearCart failed")
    }
    
    func testProductAtIndexPath()
    {
        let cartMNGR = CartManager.sharedInstance
        let productsToAdd:UInt32 = 12
        for _ in 1...productsToAdd
        {
            let product = Product()
            cartMNGR.addProduct(product)
        }
        
        let rand = Int(arc4random_uniform(productsToAdd))
        let path = NSIndexPath(forItem: rand, inSection: 0)
        
        let product = cartMNGR.productAtIndexPath(path)
        
        XCTAssertNotNil(product, "fetching product via indexPath failed")
        cartMNGR.clearCart()
    }
}










