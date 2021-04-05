//
//  UHBCustomLabel.swift
//  Café-Nibm
//
//  Created by Gayan Disanayaka on 2/22/21.
//  Copyright © 2021 Gayan Disanayaka. All rights reserved.
//

import UIKit

open class UHBCustomLabel : UILabel {
    @IBInspectable open var characterSpacing:CGFloat = 1 {
        didSet {
            updateWithSpacing()
        }

    }

    open override var text: String? {
        set {
            super.text = newValue
            updateWithSpacing()
        }
        get {
            return super.text
        }
    }
    open override var attributedText: NSAttributedString? {
        set {
            super.attributedText = newValue
            updateWithSpacing()
        }
        get {
            return super.attributedText
        }
    }
    func updateWithSpacing() {
        let attributedString = self.attributedText == nil ? NSMutableAttributedString(string: self.text ?? "") : NSMutableAttributedString(attributedString: attributedText!)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: self.characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        super.attributedText = attributedString
    }
}
