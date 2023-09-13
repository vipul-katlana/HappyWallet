//
//  UIView+Extension.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import Foundation
import UIKit
import SDWebImage

extension UIView {
    
    func setCornerRadiusAndShadow(cornerRe: CGFloat) {
        self.layer.cornerRadius = cornerRe
        self.setShadow()
    }
    
    func setShadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 2
    }
    
    func setCornerRadius() {
        self.layer.cornerRadius = 5
    }
    
    
    func addLoginButtonShadowAndCornerRadius() {
        self.layer.cornerRadius = 10
        self.layer.shadowRadius = 3.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    
}


extension UIImageView {
    
    func changePngColorTo(color: UIColor){
        guard let image =  self.image else {return}
        self.image = image.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
        
    }
    
    func setImage(strImagePath: String, placeHolderImage: UIImage = UIImage(named: "placeholder")!, isFixContentMode: UIImageView.ContentMode = .scaleAspectFill) {
        self.contentMode = isFixContentMode
        let url = URL(string: strImagePath)
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_setImage(with: url, placeholderImage: placeHolderImage,options: SDWebImageOptions(rawValue: 0), completed: { image, error, cacheType, imageURL in
            if image != nil {
                self.contentMode = isFixContentMode
            }
        })
        
    }
}

extension UIImage {
    
    func compressTo(_ expectedSizeInMb:Double) -> Data? {
        let sizeInBytes = expectedSizeInMb * 1024 * 1024
        var needCompress:Bool = true
        var imgData:Data?
        var compressingValue:CGFloat = 1.0
        while (needCompress && compressingValue > 0.0) {
            if let data:Data = self.jpegData(compressionQuality: compressingValue) {
                if data.count < Int(sizeInBytes) {
                    needCompress = false
                    imgData = data
                } else {
                    compressingValue -= 0.1
                }
            }
        }
        
        if let data = imgData {
            if (data.count < Int(sizeInBytes)) {
                return data
            }
        }
        return nil
    }
}


extension UIView {
    
    func takeScreenshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image ?? UIImage()
    }
}

extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }
}
