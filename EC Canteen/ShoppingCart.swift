//
//  ShoppingCart.swift
//  EC Canteen
//
//  Created by John on 22/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit

class shoppingCart{
    var shoppingCartArray = [Meal]()
    var canteenName = ""
    var orderHistory = [Meal]()
    static let sharedShoppingCart = shoppingCart()
}
