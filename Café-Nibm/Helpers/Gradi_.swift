// GradientView.swift
//  Aura
//
//  Created by Egor Sakhabaev on 23.07.17.
//  Copyright © 2017 Egor Sakhabaev. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIButton {
    
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



@IBDesignable
class GradientViewLabel: UILabel {
    
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




@IBDesignable
class GradientView_VIEWS: UIView {
    
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

