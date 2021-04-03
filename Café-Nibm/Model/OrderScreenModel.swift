//
//  OrderScreenModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/4/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import CoreLocation
import  UIKit

class OrderScreenModel {
    
   
    var foodName: String?
    var itemPrice: String?
    var noUnits: String?
    var amount: String?
 
    
    
    init(foodName: String?, itemPrice: String?, noUnits: String?, amount: String?){
        self.foodName = foodName
        self.itemPrice = itemPrice
        self.noUnits = noUnits
        self.amount = amount
        
    }
}
