//
//  BasketTableViewCell.swift
//  ComerseApp
//
//  Created by Andreas Märki on 26/06/16.
//  Copyright © 2016 andreasMaerki. All rights reserved.
//

import UIKit

class BasketTableViewCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var productImage: UIView!
    @IBOutlet weak var productNameLBL: UILabel!
    @IBOutlet weak var productPriceLBL: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
