//
//  ReadyOrderTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class ReadyOrderTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var orderId: UILabel!
    
    @IBOutlet weak var eView: UIView!
    
    @IBOutlet weak var finishButton: GradientView!
    var delegateReady: ReadyOrderDelegate?
    var Index: IndexPath?
    
    

       @IBOutlet var cityButtons: [UIButton]!
       
       @IBOutlet weak var selectedButton: UIButton!
       
       
       @IBAction func handleSelection(_ sender: UIButton) {
           cityButtons.forEach { (button) in
               UIView.animate(withDuration: 0.5, animations: {
                   button.isHidden = !button.isHidden
                   
                   self.delegateReady?.onhandleSelection_Ready()
                   
               })
           }
       }
       
    
       
       
       @IBAction func cityTapped(_ sender: UIButton) {
          
           delegateReady?.onStatusTapped_Ready(title: sender.currentTitle ?? "", Index: Index!.row)
           
         if(sender.currentTitle != "Finish"){
               
               self.selectedButton.setTitle(sender.currentTitle, for: .normal)
           }
           
           
           cityButtons.forEach { (button) in
                      UIView.animate(withDuration: 0.5, animations: {
                          button.isHidden = true
                          
                         
                          
                      })
                  }
       
           
       }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        selectedButton.layer.borderWidth = 0.5
        selectedButton.layer.masksToBounds = false
        selectedButton.layer.borderColor = UIColor.black.cgColor
        selectedButton.layer.cornerRadius = selectedButton.frame.height/2
        selectedButton.clipsToBounds = true
        selectedButton.alpha = 1
        
        
        finishButton.layer.borderWidth = 0.5
               finishButton.layer.masksToBounds = false
        finishButton.layer.borderColor = UIColor.black.cgColor
               finishButton.layer.cornerRadius = finishButton.frame.height/2
               finishButton.clipsToBounds = true
               finishButton.alpha = 1
               
        
        
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


protocol ReadyOrderDelegate {
   
     func onStatusTapped_Ready(title: String, Index: Int)
     func onhandleSelection_Ready()
    
    
    
}
