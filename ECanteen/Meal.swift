//
//  Meal.swift
//  tonightEatWhat
//
//  Created by Sam on 30/11/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class Meal{
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var price: Double
    var itemId: Int
    
    init?(name: String, photo:UIImage?,price:Double, itemId:Int) {
        self.name = name
        self.photo = photo
        self.price = Double(Int(price * 100) / 100)
        self.itemId = itemId
        
        if name.isEmpty || price<0 {
            return nil
        }
    }
}
