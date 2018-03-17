//
//  Constants.swift
//  ECanteen
//
//  Created by John on 11/2/2018.
//  Copyright © 2018年 jaar.ga. All rights reserved.
//

import Foundation

struct Constants {
    static let API_BASE = "http://projgw.cse.cuhk.edu.hk:2887/api"
    static var deviceToken = ""
//    static let API_BASE = "http://192.168.0.142:8000"
    
    static func decimalToInt (decimal: String) -> Int {
        if (decimal == "") {
            return 0
        }
        do {
            let regex = try NSRegularExpression(pattern: "\\d+")
            let results = regex.matches(in: decimal, range: NSRange(location: 0, length: decimal.utf8.count))
            
            let result = results.map {
                String(decimal[Range($0.range, in: decimal)!])
            }
            
            print(result[0]!)
            print(result[1]!)
            
            var output =  Int(result[0]!)! * 100
            if result[1]!.count == 1 {
                output += Int(result[1]!)! * 10
            } else {
                output += Int(result[1]!)!
            }
            return output
        } catch {
            return 0
        }
    }
}
