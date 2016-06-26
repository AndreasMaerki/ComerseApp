//
//  ServerConnectionTests.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import XCTest
@testable import ComerseApp

class ServerConnectionTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testGetExchangeRateForCurrency()
    {
        let validCurrencyStr = "USD"
        let invalidCurrencyStr = "NDLFJ"
        
        let serverConnection = ServerConnection()
        let asyncExpectation = expectationWithDescription("currrencyAPICall")
        
        serverConnection.getExchangeRateForCurrency(validCurrencyStr) { (retDic:Dictionary<String, AnyObject>) -> () in
            
            XCTAssertNotNil(retDic, "retDic was nil")
            XCTAssertNil(retDic["error"], "\(retDic["error"])")
            asyncExpectation.fulfill()
        }
        
        serverConnection.getExchangeRateForCurrency(invalidCurrencyStr) { (retDic:Dictionary<String, AnyObject>) -> () in
            
            XCTAssertNotNil(retDic, "retDic was nil")
            XCTAssertNotNil(retDic["error"], "\(retDic["error"])")
            asyncExpectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(5) { (error: NSError?) -> Void in
            XCTAssertNil(error, "something went wrong: \(error?.localizedDescription)")
        }
    }
}
