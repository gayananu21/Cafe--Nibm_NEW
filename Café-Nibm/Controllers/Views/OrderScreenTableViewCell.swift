//
//  OrderScreenTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 3/4/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class OrderScreenTableViewCell: UITableViewCell {

    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var unitPrice: UILabel!
    @IBOutlet weak var noUnits: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
