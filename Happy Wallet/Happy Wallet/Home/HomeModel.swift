//
//  HomeModel.swift
//  Happy Wallet
//
//  Created by Vipul  on 17/08/21.
//

import Foundation


struct MonthlyRecord: Codable {
    let category: String?
    let amount: String?
    let description: String?
}



struct DreamRecord: Codable {
    let category: String?
    let amount: String?
    let amountAvailable: String?
    let description: String?
}
