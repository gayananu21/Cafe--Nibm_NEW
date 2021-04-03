//
//  CartTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/2/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    var foodCount = Int()
    var total = Int()
    
    var unitPrice = Int()
    
    var allTotal = Int()
    

    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var noItems: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var foodName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

     @IBAction func plusItemTapped() {
            
        
            
            
            
            self.foodCount = self.foodCount + 1
            self.noItems.text = String(self.foodCount)
            
            self.total = self.foodCount * self.unitPrice
            self.amount.text = String(self.total)
        
            self.allTotal += self.total
        
        
        
        }
        @IBAction func minusItemTapped() {
            
       
            
             self.foodCount = self.foodCount - 1
             self.noItems.text = String(self.foodCount)
             
             self.total = self.foodCount * self.unitPrice
             self.amount.text = String(self.total)

            
        }
    }
