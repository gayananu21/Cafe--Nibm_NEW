//
//  profileRecentModel1.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/1/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import CoreLocation
import  UIKit



class ProfileRecentModel1 {
    
    
    var foodName: String?
    var noItems: String?
    var itemPrice: String?
    
    init(foodName: String?, noItems: String?, itemPrice: String?){
     
        self.foodName = foodName
        self.noItems = noItems
        self.itemPrice = itemPrice
    }
}
