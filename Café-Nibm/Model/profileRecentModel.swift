//
//  profileRecentModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/1/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import CoreLocation
import  UIKit



class ProfileRecentModel {
    
    var date: String?
    var totalAmount: String?
    var recentOrderNo: String?
   
    init(date: String?, totalAmount: String?, recentOrderNo: String?){
        self.date = date
        self.totalAmount = totalAmount
        self.recentOrderNo = recentOrderNo
        
               
        
    }
}
