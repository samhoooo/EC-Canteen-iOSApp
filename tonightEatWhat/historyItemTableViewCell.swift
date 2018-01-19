//
//  historyItemTableViewCell.swift
//  tonightEatWhat
//
//  Created by Sam on 2/12/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class historyItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
