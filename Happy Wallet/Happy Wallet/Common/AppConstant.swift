//
//  AppConstant.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import Foundation
import UIKit

struct AppConstants {
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate ?? AppDelegate()
    static let appColor = UIColor(named: "primaryColor")
    static let labelColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let navBarColor = UIColor(named: "secondaryColor")
    static let navBarTextColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    static let appName = "Happy Wallet"
    static let appStoreId = ""
    static let appStoreLink = "https://apps.apple.com/gb/app/id\(appStoreId)?action=write-review"
}


struct UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    static let applicationDefaults = UserDefaults.standard
    static private var bookData: [MonthlyRecord]?
    
    static private var dremData: [DreamRecord]?
    
    static func setMonthlyData(loginModel: [MonthlyRecord]) {
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(loginModel)
        applicationDefaults.setValue(encodedData, forKey: "LoginModel")
        applicationDefaults.synchronize()
    }
    
    
    static func getMonthlyData() -> [MonthlyRecord]? {
        if let decoded = applicationDefaults.object(forKey: "LoginModel") as? Data {
            let decoder = JSONDecoder()
            let decodedUser = try? decoder.decode([MonthlyRecord].self, from: decoded)
            bookData = decodedUser
        }
        return bookData
    }
    
    static func resetMonthData() {
        applicationDefaults.setValue(nil, forKey: "LoginModel")
    }
    
    static func setDreamData(loginModel: [DreamRecord]) {
        let encoder = JSONEncoder()
        let encodedData = try? encoder.encode(loginModel)
        applicationDefaults.setValue(encodedData, forKey: "DreamRecord")
        applicationDefaults.synchronize()
    }
    
    
    static func getDreamData() -> [DreamRecord]? {
        if let decoded = applicationDefaults.object(forKey: "DreamRecord") as? Data {
            let decoder = JSONDecoder()
            let decodedUser = try? decoder.decode([DreamRecord].self, from: decoded)
            dremData = decodedUser
        }
        return dremData
    }
    
    static func resetDreamData() {
        applicationDefaults.setValue(nil, forKey: "DreamRecord")
    }
    
    
    func setAmount(amount: String) {
        UserDefaultsManager.applicationDefaults.set(amount, forKey: "myAmount")
    }
    
    func getAmount() -> String {
        UserDefaultsManager.applicationDefaults.string(forKey: "myAmount") ?? "0"
    }
    
    
    
    func setMonth(month: String) {
        UserDefaultsManager.applicationDefaults.set(month, forKey: "myMonth")
    }
    
    func getMonth() -> String {
        UserDefaultsManager.applicationDefaults.string(forKey: "myMonth") ?? ""
    }
}
