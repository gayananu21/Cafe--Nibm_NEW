//
//  SurveyButton.swift
//  Try_Button
//
//  Created by Gayan Disanayaka on 4/5/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

class SurveyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
        
    }
    
    func setupButton(){
        setTitleColor(.white, for: .normal)
        backgroundColor = .red
        titleLabel?.font = UIFont(name: "montserrat_light", size: 20)
        layer.cornerRadius = 10
    }

}
