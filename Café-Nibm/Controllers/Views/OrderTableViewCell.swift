//
//  OrderTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/25/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNumber: UILabel!
    
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBOutlet weak var kImage: UIImageView!
    @IBOutlet weak var pImage: UIImageView!
    @IBOutlet weak var rImage: UIImageView!
    
    @IBOutlet weak var kStatus: UILabel!
    @IBOutlet weak var pStatus: UILabel!
    @IBOutlet weak var rStatus: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
