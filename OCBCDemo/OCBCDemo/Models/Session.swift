//
//  Session.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

enum ServiceStatus: Decodable {
    
    case success
    case failed
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let status = try? container.decode(String.self)
        switch status {
        case "success": self = .success
        default:
           self = .failed
        }
    }
}

struct Session: Decodable {
    
    let status: ServiceStatus!
    let token: String?
    let failureDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case token = "token"
        case failureDescription = "description"
    }
}

struct BalanceGetter: Decodable {
    
    let status: ServiceStatus!
    let balance: Double?
    let failureDescription: String?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case balance = "balance"
        case failureDescription = "description"
    }
}
