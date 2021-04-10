//
//  OrderDetailTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 4/9/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var noItems: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
