//
//  ProductsTableViewCell.swift
//  DreamProductLister
//
//  Created by Venkateswara on 24/11/16.
//  Copyright © 2016 Sindhu. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    
    func configureCell(item: Item) {
        productTitle.text = item.title
        productPrice.text = ("\(item.price)")
        productDescription.text = item.details
        productImage.image = item.toImage?.image as? UIImage
    }
    
}
