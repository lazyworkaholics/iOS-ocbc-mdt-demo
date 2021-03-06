//
//  Transaction.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

enum TransactionType: Decodable {
    case receive
    case transfer
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "receive": self = .receive
        default:
           self = .transfer
        }
    }
}

struct Transaction: Decodable {
    
    var id: String!
    var type: TransactionType!
    var amount: Double!
    var currency: String!
    var accountNo: String!
    var accountName: String!
    var description: String?
    var date: Date!
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case amount = "amount"
        case currency = "currency"
        case description = "description"
        case date = "date"
        case to = "to"
        case from = "from"
        case accountNo = "accountNo"
        case accountName = "accountHolderName"
    }
    
    init(from decoder:Decoder) throws {
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            type = try container.decodeIfPresent(TransactionType.self, forKey: .type)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            amount = try container.decodeIfPresent(Double.self, forKey: .amount)
            currency = try container.decodeIfPresent(String.self, forKey: .currency)
            date = try Utilities().getDate(container.decodeIfPresent(String.self, forKey: .date)!)
            
            if container.allKeys.contains(.to) {
                let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .to)
                accountNo = try nestedContainer.decodeIfPresent(String.self, forKey: .accountNo)
                accountName = try nestedContainer.decodeIfPresent(String.self, forKey: .accountName)
            }
            else if container.allKeys.contains(.from) {
                let nestedContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .from)
                accountNo = try nestedContainer.decodeIfPresent(String.self, forKey: .accountNo)
                accountName = try nestedContainer.decodeIfPresent(String.self, forKey: .accountName)
            }
        } catch {
            throw error
        }
    }
    
    func dateString() -> String {
        return Utilities().getDateString(date)
    }
    
    func nameAndNumber() -> String {
        return (accountName + " - " + accountNo)
    }
    
    func amountString() -> String {
        
        var tuple = currency
        if type == .transfer {
            tuple = tuple! + " - "
        } else  {
            tuple = tuple! + " "
        }
        tuple = tuple! + String(format: "%.2f", amount)
        return tuple!
    }
}

struct TransactionGetter: Decodable {
    
    let status: ServiceStatus!
    let transactions: [Transaction]?
    let failureDescription: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case transactions = "data"
        case failureDescription = "description"
    }
}
