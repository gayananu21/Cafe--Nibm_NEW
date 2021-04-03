//
//  RestaurantTableViewCell.swift
//  Resturant
//
//  Created by Gayan Disanayaka on 2/23/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit


protocol RestaurantTableViewCellDelegate: AnyObject {

   func plusItemTapped()
   func minusItemTapped()
    
    
}

class RestaurantTableViewCell: UITableViewCell {
    
    
    
    weak var delegate: RestaurantTableViewCellDelegate?


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

    @IBAction func plusItemTapped() {
        
        
        delegate?.plusItemTapped()
        
        self.foodCount = self.foodCount + 1
        self.homeCartEditCount.text = String(self.foodCount)
        
        self.total = self.foodCount * self.unitPrice
        self.homeCartCornerLabel.text = String(self.total)
    }
    @IBAction func minusItemTapped() {
        
   
         delegate?.minusItemTapped()
        
        self.foodCount = self.foodCount - 1
        self.homeCartEditCount.text = String(self.foodCount)
        self.total = self.foodCount * self.unitPrice
        self.homeCartCornerLabel.text = String(self.total)

        
    }
}
