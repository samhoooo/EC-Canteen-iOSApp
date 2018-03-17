//
//  Meal.swift
//  tonightEatWhat
//
//  Created by Sam on 30/11/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import UIKit
import SwiftyJSON

class Option {
    var optionId: Int
    var name: String
    var eng_name: String
    var price: Int
    var soldout: Bool
    var selected: Bool
    
    init (option: JSON) {
        self.optionId = option["optionid"].intValue
        self.name = option["option_name"].stringValue
        self.eng_name = option["option_eng_name"].stringValue
        self.price = Constants.decimalToInt(decimal: option["price"].stringValue)
        self.soldout = option["soldout"].boolValue
        self.selected = false
    }
}

class Attribute: Equatable {
    var attributeId: Int
    var name: String
    var eng_name: String
    var multi_select: Int
    var options: [Option]
    
    init (attribute: JSON) {
        self.attributeId = attribute["attributeid"].intValue
        self.name = attribute["attribute_name"].stringValue
        self.eng_name = attribute["attribute_eng_name"].stringValue
        self.multi_select = attribute["multi_select"].intValue
        self.options = attribute["options"].arrayValue.map { Option(option: $0) }
    }
    
    static func == (lhs: Attribute, rhs: Attribute) -> Bool {
        return lhs.attributeId == rhs.attributeId
    }
    
    func selectedOptions() -> [[String : Any]] {
        return self.options.flatMap {
            if $0.selected {
                return ["optionid": $0.optionId]
            }
            return nil
        }
    }
    
}

class Item {
    //MARK: Properties
    
    var itemId: Int
    var name: String
    var eng_name: String
    var photo: UIImage?
    var price: Int
    var quantity: Int
    var attributes: [Attribute]
    
    init? (item: JSON) {
        if (item["type"] == "normal") {
            self.itemId = item["itemid"].intValue
            self.name = item["name"].stringValue
            self.eng_name = item["eng_name"].stringValue
            self.photo = UIImage(named: "coffeecon_meal\(2)")
            self.price = Constants.decimalToInt(decimal: item["price"].stringValue)
            self.attributes = item["attributes"].arrayValue.map { Attribute(attribute: $0) }
            self.quantity = 1
        } else {
            return nil
        }
    }
    
    init () {
        self.itemId = 0
        self.name = ""
        self.eng_name = ""
        self.photo = UIImage(named: "coffeecon_meal\(2)")
        self.price = 0
        self.attributes = []
        self.quantity = 1
    }
    
    func attributesOutputJSON() -> [[String:Any]] {
        return self.attributes.map{["attributeid": $0.attributeId, "options": $0.selectedOptions()]}
    }
}

class Column {
    var columnId: Int
    var column_name: String
    var eng_column_name: String
    var items: [Item]
    
    init (column: JSON) {
        self.columnId = column["columnid"].intValue
        self.column_name = column["column_name"].stringValue
        self.eng_column_name = column["eng_column_name"].stringValue
        self.items = column["items"].arrayValue.flatMap { Item(item: $0) }
    }
}

class Menu {
    var menuId: Int
    var restaurantId: Int
    var menu_type: String
    var eng_meng_type: String
    var columns: [Column]
    
    init (menu: JSON) {
        self.menuId = menu["menuid"].intValue
        self.restaurantId = menu["restaurantId"].intValue
        self.menu_type = menu["menu_type"].stringValue
        self.eng_meng_type = menu["eng_menu_type"].stringValue
        self.columns = menu["columns"].arrayValue.map { Column(column: $0) }
    }
    
    init () {
        self.menuId = 0
        self.restaurantId = 0
        self.menu_type = ""
        self.eng_meng_type = ""
        self.columns = []
    }
}
