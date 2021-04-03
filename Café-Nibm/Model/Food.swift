

import CoreLocation
import  UIKit

class FoodModel {
    
    var description: String?
    var name: String?
    var price: String?
    var foodImage: String?
    
    init(description: String?, name: String?, price: String?, foodImage: String?){
        self.description = description
        self.name = name
        self.price = price
        self.foodImage = foodImage
    }
}
