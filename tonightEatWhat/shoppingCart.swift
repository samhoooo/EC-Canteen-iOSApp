//
//  shoppingCart.swift
//  tonightEatWhat
//
//  Created by Sam on 1/12/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit

class shoppingCart{
    var shoppingCartArray = [Meal]()
    var canteenName = ""
    var orderHistory = [Meal]()
    static let sharedShoppingCart = shoppingCart()
}
