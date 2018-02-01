//
//  savedPageViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit
import Stripe

class savedPageViewController: UIViewController {

    @IBOutlet weak var totalTextView: UILabel!
    @IBOutlet weak var checkoutButtonView: UIButton!
    @IBOutlet weak var restaurantTextView: UILabel!
    
    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //calculate total price
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        var totalPrice = 0.0
        for item in shoppingCartInstance.shoppingCartArray{
            totalPrice += item.price
        }
        totalTextView.text = "$"+String(format: "%.1f",totalPrice) //update total price label
        restaurantTextView.text = shoppingCartInstance.canteenName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkoutButtonOnClick(_ sender: Any) {
        print("button clicked")
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        var totalPrice = 0.0
        for item in shoppingCartInstance.shoppingCartArray{
            totalPrice += item.price
        }
        if(totalPrice>0){
            let checkoutViewController = CheckoutViewController(product: "堂食預訂",
                                                            price: Int(Float(totalPrice)*100),
                                                            settings: self.settingsVC.settings)
            self.navigationController?.pushViewController(checkoutViewController, animated: true)
        }else{
            let alert = UIAlertController(title: "沒有訂單",
                                          message: "沒有訂單 請先點餐！",
                                          preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: UIAlertActionStyle.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}