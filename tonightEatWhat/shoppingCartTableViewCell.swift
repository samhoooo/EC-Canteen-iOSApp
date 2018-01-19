//
//  shoppingCartTableViewCell.swift
//  tonightEatWhat
//
//  Created by Sam on 1/12/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class shoppingCartTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImageView: UIImageView!
    @IBOutlet weak var mealNameTextView: UILabel!
    @IBOutlet weak var priceTextView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
