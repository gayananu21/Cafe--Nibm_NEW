//
//  RestaurantTableViewCell.swift
//  Resturant
//
//  Created by Gayan Disanayaka on 2/23/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit


class RestaurantTableViewCell: UITableViewCell {
    
    
    var delegate: FoodStatusDelegate?
    var Index: IndexPath?
    var Status: UISwitch?
    
    

  
    @IBOutlet weak var foodSwitch: UISwitch!
    

    @IBOutlet weak var foodPriceType: UILabel!
    @IBOutlet weak var foodDiscount: RoundLabel!
    @IBOutlet weak var foodStatusImage: UIImageView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodDescription: UILabel!
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    
    var foodCount = Int()
    var total = Int()
    
    var unitPrice = Int()
    
   
    @IBOutlet weak var homeCartMinusButton: UIButton!
    @IBOutlet weak var homeCartEditCount: UILabel!
    @IBOutlet weak var homeCartPlusButton: UIButton!
    @IBOutlet weak var homeCartMiddleView: UIView!
    @IBOutlet weak var homeCartCornerLabel: UILabel!
    @IBOutlet weak var homeCartName: UILabel!
    
  
    
   
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onCheckAvailability(_ sender: UISwitch) {
           
        if(sender.isOn){
            
            
            delegate?.CheckAvailability(Index: Index!.row, isOn: true)
        }
        
        else{
            delegate?.CheckAvailability(Index: Index!.row, isOn: false)
        }
        
           
       }
       

   
}

protocol FoodStatusDelegate {
    func CheckAvailability(Index: Int, isOn: Bool)
    
    
    
}
