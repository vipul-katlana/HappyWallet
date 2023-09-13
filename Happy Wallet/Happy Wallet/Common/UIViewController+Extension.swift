//
//  UIViewController+Extension.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import Foundation
import UIKit
import SwiftMessages

extension UIViewController {
    
    func showTopMessage(message : String?, type : NotificationType, displayDuration: Double = 2) {
        
        if let _ = message {
            let view: MessageView = MessageView.viewFromNib(layout: .cardView)
            
            var config = SwiftMessages.defaultConfig
            
            view.configureTheme(type == .Success ? .success : .error )
            
            config.presentationContext = .window(windowLevel: UIWindow.Level.normal)
            config.duration = .seconds(seconds: displayDuration)
            config.dimMode = .none
            
            config.interactiveHide = true
            view.iconImageView?.isHidden = true
            view.iconLabel?.isHidden = true
            view.button?.isHidden = true
            view.titleLabel?.text = AppConstants.appName
            view.bodyLabel?.text = message
            
            view.configureDropShadow()
            
            config.preferredStatusBarStyle = .lightContent
            
            SwiftMessages.show(config: config, view: view)
        }
    }
    
    func displayAlert( msg: String?, ok: String, cancel: String, okAction: (() -> Void)? = nil, cancelAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title:  "\(AppConstants.appName)", message: msg, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: cancel, style: .cancel)
        { (action) in
            if let cancelAction = cancelAction {
                DispatchQueue.main.async(execute: {
                    cancelAction()
                })
            }
        }
        
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func normalDisplayAlert( msg: String?, ok: String, okAction: (() -> Void)? = nil){
        
        let alertController = UIAlertController(title:  "\(AppConstants.appName)", message: msg, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: ok, style: .default)
        { (action) in
            if let okAction = okAction {
                DispatchQueue.main.async(execute: {
                    okAction()
                })
            }
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        
        return  returnValue
    }
}


enum NotificationType : String {
    case Error
    case Success
    case Info
}



extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
