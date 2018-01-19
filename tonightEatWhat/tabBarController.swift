//
//  tabBarController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit


class tabBarController: UITabBarController {
    
    let numberOfTabs: CGFloat = 4
    let tabBarHeight: CGFloat = 60

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tab bar color initialization
            //yellow
        self.tabBar.tintColor = UIColor.init(red: 1, green: 213.0/255.0, blue: 42/255.0, alpha: 1)
            //grey
        self.tabBar.unselectedItemTintColor = UIColor.init(red:193.0/255.0, green:193.0/255.0,blue:193.0/255.0,alpha:1)

        //init the small line selection indicator
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: tabBar.frame.width / numberOfItems, height: tabBar.frame.height)
        tabBar.selectionIndicatorImage = UIImage.makeImageWithColorAndSize(color: UIColor.init(red: 1, green: 213.0/255.0, blue: 42/255.0, alpha: 1), size: tabBarItemSize).resizableImage(withCapInsets:)(UIEdgeInsets.zero)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

//init the small rectangle selection indicator on the top of icon
extension UIImage {
    class func makeImageWithColorAndSize(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: 0,y: 0,width: size.width,height: 2))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


