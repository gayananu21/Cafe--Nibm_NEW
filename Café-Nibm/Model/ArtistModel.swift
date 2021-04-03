//
//  ArtistModel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/28/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//


import CoreLocation
import  UIKit



class ArtistModel {
    
    var id: String?
    var name: String?
    var genre: String?
    
    init(id: String?, name: String?, genre: String?){
        self.id = id
        self.name = name
        self.genre = genre
    }
}
