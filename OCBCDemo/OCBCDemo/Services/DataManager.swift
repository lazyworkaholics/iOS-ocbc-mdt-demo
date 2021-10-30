//
//  DataManager.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import Foundation

struct DataManager {
    
    static var apiToken: String?
    static var balanceGetter:BalanceGetter?
    static var payeeGetter:PayeeGetter?
    static var transactionGetter:TransactionGetter?
}
