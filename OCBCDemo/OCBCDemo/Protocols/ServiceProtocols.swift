//
//  ServiceProtocols.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

protocol NetworkManagerProtocol
{
    var baseURL: String? {get set}
    var urlSession: URLSession {get set}
    var isConnectedToNetwork: Bool {get set}
    func httpRequest(_ urlPath:String,
                     params: [String: String]?,
                     method: HTTPRequestType,
                     headers: [String: String]?,
                     body: Data?,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void)
}
