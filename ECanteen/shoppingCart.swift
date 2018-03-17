//
//  shoppingCart.swift
//  tonightEatWhat
//
//  Created by Sam on 1/12/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class shoppingCart{
    var shoppingCartArray = [Item]()
    var restaurantId = 0
    var orderHistory = [Item]()
    static let sharedShoppingCart = shoppingCart()
    
    func outputJSON () -> [[String:Any]] {
        return self.shoppingCartArray.map{["itemid":$0.itemId, "attributes": $0.attributesOutputJSON()]}
    }
}
