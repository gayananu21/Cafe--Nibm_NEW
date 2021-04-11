//
//  NewOrderTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/8/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class NewOrderTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var orderId: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    
    @IBOutlet weak var acceptButton: UIButton!
    
    var delegate: newOrderDelegate?
    var Index: IndexPath?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        acceptButton.layer.borderWidth = 0.5
        acceptButton.layer.masksToBounds = false
        acceptButton.layer.borderColor = UIColor.green.cgColor
        acceptButton.layer.cornerRadius = acceptButton.frame.height/2
        acceptButton.clipsToBounds = true
        acceptButton.alpha = 1
        
        
        rejectButton.layer.borderWidth = 0.5
               rejectButton.layer.masksToBounds = false
        rejectButton.layer.borderColor = UIColor.red.cgColor
               rejectButton.layer.cornerRadius = rejectButton.frame.height/2
               rejectButton.clipsToBounds = true
               rejectButton.alpha = 1
        

    }

    @IBAction func onAcceptOrder(_ sender: Any) {
        
        delegate?.onAcceptOrder(Index: Index!.row)
        
    }
    @IBAction func onRejectOrder(_ sender: Any) {
        
         delegate?.onRejectOrder(Index: Index!.row)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


protocol newOrderDelegate {
    func onAcceptOrder(Index: Int)
    func onRejectOrder(Index: Int)
   
    
    
    
}
