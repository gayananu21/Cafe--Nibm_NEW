//
//  AdminAccountModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//



import CoreLocation
import  UIKit

class AdminAccountModel {
    
   
    var orderId: String?
    var amount: String?
    var date: String?
    

    
    init(orderId: String?, amount: String?, date: String?
){
        
        self.orderId = orderId
        self.amount = amount
        self.date = date
        
        
    }
}
