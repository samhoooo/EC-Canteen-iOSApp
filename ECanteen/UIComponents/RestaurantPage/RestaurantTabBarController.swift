//
//  RestaurantTabBarController.swift
//  EC Canteen
//
//  Created by John on 29/1/2018.
//  Copyright © 2018年 MHW1701. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
}

class RestaurantTabBarController: UITabBarController, UITabBarControllerDelegate {
    var restaurantId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        if let detailController = viewController as? RestaurantDetailController{
            detailController.restaurantId = self.restaurantId
        }
    }
    
}
