//
//  takeFoodViewController.swift
//  ECanteen
//
//  Created by Sam on 6/2/2018.
//  Copyright © 2018年 jaar.ga. All rights reserved.
//

import UIKit
import Alamofire

class takeFoodViewController: UIViewController {
    
    var payload: [AnyHashable: Any] = [:]
    var restaurantID: String = "1"
    var orderID: String = "1"
    
    @IBOutlet weak var TakeOrderButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantID = payload["restaurantid"] as! String
        orderID = payload["orderid"] as! String
        print(restaurantID)
        print(orderID)
        Alamofire.request("\(Constants.API_BASE)/restaurants/\(restaurantID)/orders/\(orderID)/take", method: .post).responseJSON { response in
            let alertController = UIAlertController(title: "Foods are Ready from \(self.restaurantID)", message: "Happy Meal! (Order: \(self.orderID))", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                self.view.removeFromSuperview()
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TakeOrderAction(_ sender: Any) {
        print("Pressed")
        Alamofire.request("\(Constants.API_BASE)/restaurants/\(restaurantID)/orders/\(orderID)/take", method: .post).responseJSON { response in
            let alertController = UIAlertController(title: "Foods are Ready from \(self.restaurantID)", message: "Happy Meal! (Order: \(self.orderID))", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: {(alert: UIAlertAction!) in
                self.view.removeFromSuperview()
            })
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
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
