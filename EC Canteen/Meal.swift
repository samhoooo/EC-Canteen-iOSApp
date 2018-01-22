//
//  Meal.swift
//  EC Canteen
//
//  Created by John on 22/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit

class Meal{
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var price: Double
    var itemId: Int
    
    init?(name: String, photo:UIImage?,price:Double,itemId:Int) {
        self.name = name
        self.photo = photo
        self.price = price
        self.itemId = itemId
        
        if name.isEmpty || price<0 {
            return nil
        }
    }
}

