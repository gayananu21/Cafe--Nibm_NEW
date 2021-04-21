//
//  ProcessingOrder.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import CoreLocation
import  UIKit

class ProcessingOrderModel {
    
    
       var userId: String?
              var orderId: String?
              var dataKey: String?
        var customerName: String?
      var distance: String?
              
             
              
        init(userId: String?, orderId: String?, dataKey: String?,  customerName: String?, distance: String?
          ){
                  self.userId = userId
                  self.orderId = orderId
                  self.dataKey = dataKey
                  self.customerName =  customerName
                  self.distance = distance
          
                
                  
              }
          }
