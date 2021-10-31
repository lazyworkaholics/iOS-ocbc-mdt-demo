//
//  Transfer.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

struct Transfer: Codable {
    
    var id: String?
    var recipientAccountNo: String!
    var amount: Double!
    var date: Date!
    var description: String!
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case recipientAccountNo = "recipientAccountNo"
        case amount = "amount"
        case date = "date"
        case description = "description"
    }
    
    init(from decoder:Decoder) throws {
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            recipientAccountNo = try container.decodeIfPresent(String.self, forKey: .recipientAccountNo)
            amount = try container.decodeIfPresent(Double.self, forKey: .amount)
            description = try container.decodeIfPresent(String.self, forKey: .description)
        } catch {
            throw error
        }
    }
    
    init(with amount: Double, recipientAccountNo: String, dateString: String, description: String) {
        
        self.amount = amount
        self.recipientAccountNo = recipientAccountNo
        self.date = Utilities().getDate(dateString)
        self.description = description
    }
}

struct MakeTransfer: Decodable {
    
    var status: ServiceStatus!
    var response: Transfer?
    var failureDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case response = "data"
        case failureDescription = "description"
    }
}
