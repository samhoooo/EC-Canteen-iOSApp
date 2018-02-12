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
    var price: Int
    var itemId: Int
    
    init?(name: String, photo:UIImage?, price:String, itemId:Int) {
        self.name = name
        self.photo = photo
        self.price = Constants.decimalToInt(decimal: price)
        print(self.price)
        self.itemId = itemId
        
        if name.isEmpty || self.price < 0 {
            return nil
        }
    }
}
