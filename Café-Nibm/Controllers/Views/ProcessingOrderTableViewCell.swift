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
            
            if(sender.currentTitle != "Ready"){
                
                self.selectedButton.setTitle(sender.currentTitle, for: .normal)
                
            }
            
            if(sender.currentTitle != "Preparing"){
                          
                          self.selectedButton.setTitle(sender.currentTitle, for: .normal)
                      }
            
            
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
        
        
    }

}

protocol processingOrderDelegate {
   
     func onStatusTapped(title: String, Index: Int)
     func onhandleSelection()
    
    
    
}
