//
//  GridCollectionViewCell.swift
//  tonightEatWhat
//
//  Created by CCH on 22/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class GridCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var checkmarkCell: UIImageView!
    var elementID: Int!

    func onSelect(_ selected: Bool) {
        if selected {
            checkmarkCell.isHidden = false
            layer.borderWidth = 5.0
        } else {
            checkmarkCell.isHidden = true
            layer.borderWidth = 0.0
        }
    }
    
    func setElement(_ item: GridItem) {
        elementID = item.id
        labelCell.text = item.name
        imageCell.image = item.image
        layer.borderColor = UIColor(red: CGFloat(46/255.0), green: (204/255.0), blue: (113/255.0), alpha: CGFloat(1.0)).cgColor
    }
}
