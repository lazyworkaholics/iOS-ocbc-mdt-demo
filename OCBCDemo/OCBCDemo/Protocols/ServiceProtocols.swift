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
                     onFailure failureBlock:@escaping (Data?, NSError)->Void)
}

protocol ServiceManagerProtocol
{
    func login( _ userName: String, password: String,
                onSuccess successBlock: @escaping (Session) -> Void,
                onFailure failureBlock: @escaping (Session?, NSError) -> Void)
    
    func getBalance( _ token: String,
                     onSuccess successBlock: @escaping (BalanceGetter) -> Void,
                     onFailure failureBlock: @escaping (Session?, NSError) -> Void)
    
    func getPayees( _ token: String,
                    onSuccess successBlock: @escaping (PayeeGetter) -> Void,
                    onFailure failureBlock: @escaping (Session?, NSError) -> Void)
    
    func getTransactions( _ token: String,
                          onSuccess successBlock: @escaping (TransactionGetter) -> Void,
                          onFailure failureBlock: @escaping (Session?, NSError) -> Void)
    
    func makeTransfer( _ token: String, transfer: Transfer,
                       onSuccess successBlock: @escaping (MakeTransfer) -> Void,
                       onFailure failureBlock: @escaping (Session?, NSError) -> Void)
    
    func getDashboardData( _ token: String,
                           onCompletion completionBlock: @escaping (BalanceGetter?, PayeeGetter?, TransactionGetter?, Session?, NSError?) -> Void)
}
