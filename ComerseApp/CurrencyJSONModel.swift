/*
Copyright (c) 2016 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class CurrencyJSONModel {
    public var success : Bool?
    public var terms : String?
    public var privacy : String?
    public var timestamp : Int?
    public var source : String?
    public var quotes : NSDictionary?
    
    /**
     Returns an array of models based on given dictionary.
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Json4Swift_Base Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [CurrencyJSONModel]
    {
        var models:[CurrencyJSONModel] = []
        for item in array
        {
            models.append(CurrencyJSONModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        success = dictionary["success"] as? Bool
        terms = dictionary["terms"] as? String
        privacy = dictionary["privacy"] as? String
        timestamp = dictionary["timestamp"] as? Int
        source = dictionary["source"] as? String
        quotes = dictionary["quotes"] as? NSDictionary
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.success, forKey: "success")
        dictionary.setValue(self.terms, forKey: "terms")
        dictionary.setValue(self.privacy, forKey: "privacy")
        dictionary.setValue(self.timestamp, forKey: "timestamp")
        dictionary.setValue(self.source, forKey: "source")
        dictionary.setValue(self.quotes, forKey: "quotes")
        
        return dictionary
    }
    
}