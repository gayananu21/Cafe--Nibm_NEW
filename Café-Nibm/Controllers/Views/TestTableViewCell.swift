//
//  TestTableViewCell.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/28/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class TestTableViewCell: UITableViewCell {

    
    @IBOutlet weak var aName: UILabel!
    @IBOutlet weak var aGenere: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
