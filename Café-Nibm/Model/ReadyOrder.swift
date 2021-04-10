//
//  ReadyOrder.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import CoreLocation
import  UIKit

class ReadyOrderModel {
    
     var userId: String?
          var orderId: String?
          var dataKey: String?
          
         
          
          init(userId: String?, orderId: String?, dataKey: String?
      ){
              self.userId = userId
              self.orderId = orderId
              self.dataKey = dataKey
              
          }
      }
