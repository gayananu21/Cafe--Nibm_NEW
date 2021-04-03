//
//  CartModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/2/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import CoreLocation
import  UIKit

class CartModel {
    
    var itemPrice: String?
    var noItems: String?
    var amount: String?
    var foodName: String?
    var cID: String?
    
   
     
    
    init(itemPrice: String?, noItems: String?, amount: String?, foodName: String?, cID: String?){
        self.itemPrice = itemPrice
        self.noItems = noItems
        self.amount = amount
        self.foodName = foodName
        self.cID = cID
       
       
    }
}
