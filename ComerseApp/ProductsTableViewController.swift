//
//  ProductsTableViewController.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import UIKit




class ProductsTableViewController: UITableViewController {
    
    let availableProducts = [
        "Bag of Peas",
        "Dozen Eggs",
        "Milk",
        "Can of Beans"]
    
    let referencePrices = [
        0.95,
        2.10,
        1.30,
        0.73]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 0.106, green: 0.114, blue: 0.145, alpha: 1.000)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController!.navigationBar.translucent = false;
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return availableProducts.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ProductsCell", forIndexPath: indexPath) as!ProductsTableViewCell
        
        cell.productNameLBL.text = availableProducts[indexPath.row]
        
        cell.productPriceLBL.text = String(format: "%.2f", referencePrices[indexPath.row])
        
        // Configure the cell...
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let product = Product()
        product.productName = availableProducts[indexPath.row]
        product.price = referencePrices[indexPath.row]
        CartManager.sharedInstance.addProduct(product)
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
