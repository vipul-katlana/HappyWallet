//
//  UIImageView+Designable.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 16/05/21.
//

import Foundation
import UIKit

@IBDesignable
class UIImageViewCustomClass: UIImageView {
    
    @IBInspectable var setTintColor : UIColor = .black {
        didSet {
            guard let image =  self.image else {return}
            self.image = image.withRenderingMode(.alwaysTemplate)
            self.tintColor = setTintColor
        }
    }
}


@IBDesignable
open class UIImageViewExtension : UIImageView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
