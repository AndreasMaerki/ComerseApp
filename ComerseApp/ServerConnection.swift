//
//  ServerConnection.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import UIKit
import Alamofire

struct Constants {
    static let currencylayerBaseURL = "http://apilayer.net/api/live"
    static let currencylayerAPIKey = "a3fad2a0fcbc36fa2c01eb163fa70921"
}

class ServerConnection: NSObject
{
    func getExchangeRateForCurrency(currency:String, completion:(Dictionary<String, AnyObject> ->()))
    {
        let URLString = Constants.currencylayerBaseURL + "?" + "access_key=" + Constants.currencylayerAPIKey + "&currencies=" + currency + "&format=1"
        Alamofire.request(.GET, URLString, parameters: nil).responseJSON { response in
            if let responseDic = response.result.value as? Dictionary<String, AnyObject>
            {
                completion(responseDic)
            }
        }
    }
}
