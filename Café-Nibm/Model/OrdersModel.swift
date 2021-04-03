//
//  OrdersModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/1/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import CoreLocation
import  UIKit

class OrdersModel {
    
    var orderNumber: String?
    var totalAmount: String?
    var orderStatus: String?
  
    
    init(orderNumber: String?, totalAmount: String?, orderStatus: String?){
        self.orderNumber = orderNumber
        self.totalAmount = totalAmount
        self.orderStatus = orderStatus
        
    }
}
