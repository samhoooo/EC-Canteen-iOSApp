//
//  savedPageViewController.swift
//  tonightEatWhat
//
//  Created by Joker on 4/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit
import Stripe
import Alamofire
import SwiftyJSON
import Alipay


class savedPageViewController: UIViewController {

    @IBOutlet weak var totalTextView: UILabel!
    @IBOutlet weak var checkoutButtonView: UIButton!
    
    let settingsVC = SettingsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //calculate total price
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        var totalPrice = 0
        for item in shoppingCartInstance.shoppingCartArray{
            totalPrice += item.price
        }
        totalTextView.text = "$"+String(format: "%.1f",Double(totalPrice)/100) //update total price label
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var deviceToken:String = ""
    
    @IBAction func checkoutButtonOnClick(_ sender: Any) {
        print("button clicked")
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        var totalPrice = 0
        for item in shoppingCartInstance.shoppingCartArray{
            totalPrice += item.price
        }
        if(totalPrice>0){
            
            //Choose payment methods
            let choiceAlert = UIAlertController(title: "選擇付款方法", message: "我們提供幾種方便的付款方法", preferredStyle: UIAlertControllerStyle.actionSheet)
            
            
            //if alipay is chosen
            choiceAlert.addAction(UIAlertAction(title: "支付寶", style: UIAlertActionStyle.default, handler: {_ in
                var subject:String = "堂食預訂"
                var out_trade_no:String  = "123"  //This is to identify a specific order
                
                let shoppingCartInstance = shoppingCart.sharedShoppingCart
                var totalPrice = 0
                for item in shoppingCartInstance.shoppingCartArray{
                    totalPrice += item.price
                }
                
                var total_amount:Double = Double(totalPrice)
                var product_code:String = "QUICK_MSECURITY_PAY"
                
                let parameters = ["cart": shoppingCartInstance.outputJSON(), "iosDeviceToken": Constants.deviceToken] as [String : Any]
                let endpoint = "\(Constants.API_BASE)/restaurants/\(shoppingCartInstance.restaurantId)/orders"

                Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON{ response in
                    if let JSONData = response.result.value {
                        let parsedJSON = JSON(JSONData)
                        out_trade_no = parsedJSON["order_id"].stringValue
                        total_amount = parsedJSON["amount"].doubleValue
                    }
                }
                
                let aliOrder = AlipayOrder(subject: subject,out_trade_no: out_trade_no,total_amount: total_amount,product_code: product_code)
                aliOrder.getRequestString()
                
                // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
                //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
                //let signer = RSADataSigner(privateKey: aliOrder.private_key)
                
            }))
            
            //if stripe is chosen
            choiceAlert.addAction(UIAlertAction(title: "Stripe", style: UIAlertActionStyle.default, handler: {_ in
                let endpoint = "\(Constants.API_BASE)/restaurants/\(shoppingCartInstance.restaurantId)/orders"
                let parameters = ["cart": shoppingCartInstance.outputJSON(), "iosDeviceToken": Constants.deviceToken] as [String : Any]
                
                Alamofire.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
                    if let JSONData = response.result.value {
                        let parsedJSON = JSON(JSONData)
                        print(parsedJSON["amount"].stringValue)
                        print(Constants.decimalToInt(decimal: parsedJSON["amount"].stringValue))
                        
                        let checkoutViewController = CheckoutViewController(product: "堂食預訂",
                                                                            price: Constants.decimalToInt(decimal: parsedJSON["amount"].stringValue),
                                                                            settings: self.settingsVC.settings,
                                                                            restaurantID: shoppingCartInstance.restaurantId,
                                                                            orderID: parsedJSON["order_id"].intValue)
                        self.navigationController?.pushViewController(checkoutViewController, animated: true)
                    } else {
                        let alert = UIAlertController(title: "錯誤：無法取得總額",
                                                      message: "請稍後再試",
                                                      preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "Ok",
                                                      style: UIAlertActionStyle.default,
                                                      handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }))
            self.present(choiceAlert, animated: true, completion: nil)
            
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
