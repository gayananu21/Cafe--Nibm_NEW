//
//  OrderDetailModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import CoreLocation
import  UIKit

class OrderDetailMenu {
    
   
    var name: String?
    var price: String?
    var foodImage: String?
    var noItems: String?

    
    init(name: String?, price: String?, foodImage: String?,  noItems: String?
){
        
        self.name = name
        self.price = price
        self.foodImage = foodImage
        self.noItems = noItems
        
    }
}
