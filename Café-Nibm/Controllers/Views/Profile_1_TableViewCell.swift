//
//  Profile_1_TableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/26/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class Profile_1_TableViewCell: UITableViewCell {

 
    @IBOutlet weak var noItems: UILabel!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
