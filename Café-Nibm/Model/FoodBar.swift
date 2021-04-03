//
//  FoodBar.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/24/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import CoreLocation
import  UIKit

struct FoodBar {
    let bar1: String
    let bar2: String
    let bar3: String
    let bar4: String
    let bar5: String
    let bar6: String
    

    
    init(dictionary: [String: Any]) {
        self.bar1 = dictionary["bar1"] as? String ?? ""
        self.bar2 = dictionary["bar1"] as? String ?? ""
        self.bar3 = dictionary["bar1"] as? String ?? ""
        
        self.bar4 = dictionary["bar1"] as? String ?? ""
        self.bar5 = dictionary["bar1"] as? String ?? ""
        self.bar6 = dictionary["bar1"] as? String ?? ""
    }
}
