//
//  Payee.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

struct Payee: Decodable {
    
    var id: String!
    var accountName: String!
    var accountNo: String!
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case accountName = "accountHolderName"
        case accountNo = "accountNo"
    }
    
    init(from decoder:Decoder) throws {
        do {
            let container = try decoder.container(keyedBy:CodingKeys.self)
            id = try container.decodeIfPresent(String.self, forKey: .id)
            accountName = try container.decodeIfPresent(String.self, forKey: .accountName)
            accountNo = try container.decodeIfPresent(String.self, forKey: .accountNo)
        } catch {
            throw error
        }
    }
}

struct PayeeGetter: Decodable {
    
    let status: ServiceStatus!
    let payees: [Payee]?
    let failureDescription: String?

    enum CodingKeys: String, CodingKey {
        case status = "status"
        case payees = "data"
        case failureDescription = "description"
    }
}
