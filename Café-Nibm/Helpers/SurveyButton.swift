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
        titleLabel?.font = UIFont(name: "montserrat_light", size: 12)
        layer.cornerRadius = 10
        
        
        
    }
    
    @IBInspectable var firstColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }

    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    func updateView() {
        let layer = self.layer as! CAGradientLayer
        layer.colors = [firstColor, secondColor].map {$0.cgColor}
        if (isHorizontal) {
            layer.startPoint = CGPoint(x: 0, y: 0.5)
            layer.endPoint = CGPoint (x: 1, y: 0.5)
        } else {
            layer.startPoint = CGPoint(x: 0.5, y: 0)
            layer.endPoint = CGPoint (x: 0.5, y: 1)
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0{
          didSet{
          self.layer.cornerRadius = cornerRadius
          }
      }

      @IBInspectable var borderWidth: CGFloat = 0{
          didSet{
              self.layer.borderWidth = borderWidth
          }
      }

      @IBInspectable var borderColor: UIColor = UIColor.clear{
          didSet{
              self.layer.borderColor = borderColor.cgColor
          }
      }

}
