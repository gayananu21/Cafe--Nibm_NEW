//
//  ProfileUITableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/26/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class ProfileUITableViewCell: UITableViewCell {

 
    @IBOutlet weak var totalAmount: UILabel!

    @IBOutlet weak var orderNumber: UILabel!
    
    @IBOutlet weak var dateTime: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
