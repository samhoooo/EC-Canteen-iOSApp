//
//  notifications.swift
//  tonightEatWhat
//
//  Created by Sam on 6/2/2018.
//  Copyright © 2018年 jaar.ga. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class notifications{
//    static func requestAuthorization(){
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.badge, .sound]){
//            (success,error) in
//
//            if error != nil {
//                print("notification authorization unsuccessful")
//            }else {
//                print("notification authorization successful")
//            }
//        }
//    }
//
//    static func timedNotifications(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool)->()){
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
//        let content = UNMutableNotificationContent()
//        content.title = "領取餐點"
//        content.body = "你的餐點已完成製作，請盡快領取，謝謝"
//        let request = UNNotificationRequest(identifier: "customNotification", content: content, trigger: trigger)
//
//        UNUserNotificationCenter.current().add(request){ (error) in
//            if error != nil{
//                completion(false)
//            }else{
//                completion(true)
//            }
//        }
//
//    }
    
    static func getMyNotifcations(v: UIView) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let takeFoodView = storyboard.instantiateViewController(withIdentifier: "takeFoodView") as? takeFoodViewController
        if takeFoodView != nil {
            takeFoodView!.view.frame = (v.window!.frame)
            v.window!.addSubview(takeFoodView!.view)
            v.window!.bringSubview(toFront: takeFoodView!.view)
        }
    }
}
