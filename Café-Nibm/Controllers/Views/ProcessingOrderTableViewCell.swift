//
//  ProcessingOrderTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class ProcessingOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var orderId: UILabel!
    
    
    var delegate: processingOrderDelegate?
       var Index: IndexPath?
       
       

          @IBOutlet var cityButtons: [UIButton]!
          
          @IBOutlet weak var selectedButton: UIButton!
          
    @IBOutlet weak var readyButton: GradientView!
    
          @IBAction func handleSelection(_ sender: UIButton) {
              cityButtons.forEach { (button) in
                  UIView.animate(withDuration: 0.5, animations: {
                      button.isHidden = !button.isHidden
                      
                      self.delegate?.onhandleSelection()
                      
                  })
              }
          }
          
       
          
          
          @IBAction func cityTapped(_ sender: UIButton) {
             
              delegate?.onStatusTapped(title: sender.currentTitle ?? "", Index: Index!.row)
            
          
            
            
             // self.selectedButton.setTitle(sender.currentTitle, for: .normal)
              
              
              cityButtons.forEach { (button) in
                         UIView.animate(withDuration: 0.5, animations: {
                             button.isHidden = true
                             
                            
                             
                         })
                     }
          
              
          }
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        selectedButton.layer.borderWidth = 0.5
        selectedButton.layer.masksToBounds = false
        selectedButton.layer.borderColor = UIColor.black.cgColor
        selectedButton.layer.cornerRadius = selectedButton.frame.height/2
        selectedButton.clipsToBounds = true
        selectedButton.alpha = 1
        
        
        readyButton.layer.borderWidth = 0.5
               readyButton.layer.masksToBounds = false
        readyButton.layer.borderColor = UIColor.black.cgColor
               readyButton.layer.cornerRadius = readyButton.frame.height/2
               readyButton.clipsToBounds = true
               readyButton.alpha = 1
        
    }

}

protocol processingOrderDelegate {
   
     func onStatusTapped(title: String, Index: Int)
     func onhandleSelection()
    
    
    
}
