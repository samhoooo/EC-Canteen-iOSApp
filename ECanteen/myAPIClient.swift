//
//  myAPIClient.swift
//  tonightEatWhat
//
//  Created by Sam on 1/12/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class MyAPIClient: NSObject, STPEphemeralKeyProvider {
    
    static let sharedClient = MyAPIClient()
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }
    
    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        restaurantID: Int,
                        orderID: Int,
                        completion: @escaping STPErrorBlock) {
        // let url = self.baseURL.appendingPathComponent("charge")
        let url = "\(Constants.API_BASE)/restaurants/\(restaurantID)/orders/\(orderID)/pay"
        let params: [String: Any] = [
            "customer": "cus_BorcdMH1riFZcj",
            "amount": amount,
//            "currency" : "HKD",
            "paymentMethod": "stripe"
        ]
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        print(url);
        let shoppingCartInstance = shoppingCart.sharedShoppingCart
        var cart = [Any]()
        for item in shoppingCartInstance.shoppingCartArray{
            var cartItem = [String:Any]()
            cartItem["itemid"] = item.itemId
            cartItem["attributes"] = []
            cartItem["price"] = item.price
            cart.append(cartItem)
        }
        print("From myAPIClient: ")
        print(cart)
        
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion,
            "customer_id": "cus_BorcdMH1riFZcj",
            "cart":cart
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
}
