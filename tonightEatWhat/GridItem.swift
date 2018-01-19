//
//  Kitchenware.swift
//  tonightEatWhat
//
//  Created by CCH on 22/7/2017.
//  Copyright © 2017年 jaar.ga. All rights reserved.
//

import Foundation
import UIKit

class GridItem {
    
    // MARK: Properties
    var id: Int
    var name: String
    var image: UIImage?
    
    // MARK: Initialization
    init?(id: Int, name: String, image: UIImage?) {
        if name.isEmpty {
            return nil
        }
        self.id = id
        self.name = name
        self.image = image
    }
}
