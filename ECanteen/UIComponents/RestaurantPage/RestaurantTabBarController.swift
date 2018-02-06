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
    var canteen_id:Int = 0
    var canteen_name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected view controller")
        if let detailController = viewController as? RestaurantDetailController{
            detailController.canteen_id = self.canteen_id
            detailController.canteen_name = self.canteen_name
        }
    }
    
}
