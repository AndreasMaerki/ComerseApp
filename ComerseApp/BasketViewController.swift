//
//  BasketViewController.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import UIKit

struct CurrencyPickerConstants
{
    static let coutryName = "name"
    static let coutryCode = "countryCode"
    static let currencyCode = "currencyCode"
    static let currencytSymbol = "currencytSymbol"
    static let currencySource = "USD"
}



class BasketViewController: UIViewController, UITableViewDataSource, CurrencyDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalAmountLBL: UILabel!
    
    
    var currencyMultiplicationFactor: Double?{
        didSet{
            self.setTotalAmount()
        }
    }
    var currencySymbol = "$"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.106, green: 0.114, blue: 0.145, alpha: 1.000)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false;
        
        tableView.dataSource = self
    }
    
    
    override func viewWillAppear(animated: Bool)
    {
        tableView.reloadData()
        self.setTotalAmount()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - tableView datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return CartManager.sharedInstance.numberOfItemsInCart()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasketCell", forIndexPath: indexPath) as! BasketTableViewCell
        
        let product = CartManager.sharedInstance.productAtIndexPath(indexPath)
        cell.productNameLBL.text = product.productName
        cell.productPriceLBL.text = String(format: "%.2f", product.price)
        
        return cell
    }
    
    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            // Delete the row from the data source and remove the product from the cart
            let product = CartManager.sharedInstance.productAtIndexPath(indexPath)
            CartManager.sharedInstance.removeProduct(product)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            self.setTotalAmount()
        }
    }

    
    
    // MARK: - Currency delegate
    
    func country(country: CurrencySelectVC!, didChangeValue value: AnyObject!) {
        country.delegate = nil
        if let countryDic = value as?Dictionary<String, String>
        {
            currencySymbol = countryDic[CurrencyPickerConstants.currencytSymbol]!
            
            let currency = countryDic[CurrencyPickerConstants.currencyCode]!
            let serverConnention = ServerConnection()
            
            serverConnention.getExchangeRateForCurrency(currency, completion: { (resultDic: Dictionary<String, AnyObject>) -> () in
                let currencyModel = CurrencyJSONModel(dictionary: resultDic)
                if (currencyModel?.success == true)
                {
                    let key = CurrencyPickerConstants.currencySource + currency
                    if let multiplicationFactor = currencyModel?.quotes![key] as? Double
                    {
                        self.currencyMultiplicationFactor = multiplicationFactor
                    }
                }
            })
        }
    }
    
    
    func setTotalAmount()
    {
        totalAmountLBL.text = String(format: "\(currencySymbol) %.2f", self.getTotalAmount())
    }
    
    func getTotalAmount()->Double
    {
        var total = CartManager.sharedInstance.totalPriceInCart()
        if (currencyMultiplicationFactor != nil)
        {
            total = total * self.currencyMultiplicationFactor!
        }
        return total
    }
    
    // MARK: - BTNActions
    
    @IBAction func purchaseBTNAction(sender: UIButton)
    {
        let formatedPrice = String(format: "%.2f", self.getTotalAmount())
        let alertController = UIAlertController(title: "Purchase Products?", message: "Do you really want to purchase all items in the basket for \(currencySymbol) \(formatedPrice)?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "NO", style: .Cancel) { (action) in
            // do nothing
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "YES", style: .Default) { (action) in
            CartManager.sharedInstance.clearCart()
            self.showConfirmationDialog()
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        }

    }
    
    func showConfirmationDialog()
    {
        let alertController = UIAlertController(title: "Purchase complete", message: "", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            self.tableView.reloadData()
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
        }
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let controller = segue.destinationViewController as? CurrencySelectVC
        {
            controller.delegate = self
        }
    }
    
}
