//
//  GlobalUtility.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import Foundation
import UIKit
@objc class GlobalUtility: NSObject {
    
    static let shared: GlobalUtility = {
        let instance = GlobalUtility()
        
        return instance
    }()
    
    func currentTopViewController() -> UIViewController {
        var topVC: UIViewController? = AppConstants.appDelegate.window?.rootViewController
        while ((topVC?.presentedViewController) != nil) {
            topVC = topVC?.presentedViewController
        }
        return topVC!
    }
    
    static func showHud() {
        
        let aStoryboard = UIStoryboard(name: "Loader", bundle: nil)
        let aVCObj = aStoryboard.instantiateViewController(withIdentifier: "LoaderVC") as! LoaderVC
        let aParent = AppConstants.appDelegate.window
        aVCObj.view.frame = UIScreen.main.bounds
        aVCObj.view.tag  = 10000
        aParent?.addSubview(aVCObj.view)
    }
    
    static func hideHud() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        let aParent = AppConstants.appDelegate.window
        for view in (aParent?.subviews)!
        {
            if view.tag == 10000
            {
                view.removeFromSuperview()
            }
        }
    }
    
    func UTCToLocal(date:String,format:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        let dt = dateFormatter.date(from: date)
        return dt!
    }
    
    func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) y ago"
        } else if (components.year! >= 1){
            if (numericDates){
                return "1 y ago"
            } else {
                return "Last year"
            }
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            if (numericDates){
                return "1 week ago"
            } else {
                return "Last week"
            }
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            if (numericDates){
                return "1 day ago"
            } else {
                return "Yesterday"
            }
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            if (numericDates){
                return "1 hour ago"
            } else {
                return "An hour ago"
            }
        } else if (components.minute! >= 2) {
            return "\(components.minute!) mins ago"
        } else if (components.minute! >= 1){
            if (numericDates){
                return "1 min ago"
            } else {
                return "A minute ago"
            }
        }
        else {
            return "Just now"
        }
    }
}
