//
//  ServiceManager.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation
struct ServiceManager: ServiceManagerProtocol   {
    
    var networkManager:NetworkManagerProtocol
    static var token:String?
    
    init() {
        self.networkManager = NetworkManager.init(NETWORK.BASE_URL)
    }
    
    // MARK: - 1. Login Service
    func login( _ userName: String, password: String,
                onSuccess successBlock: @escaping (Session) -> Void,
                onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        
        let path = NETWORK.PATH.LOGIN
        let headers = [NETWORK.HEADERS.CONTENT_TYPE: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.ACCEPT: NETWORK.HEADERS.APP_JSON]
        let body:[String : String] = [NETWORK.BODY.USERNAME:userName, NETWORK.BODY.PASSWORD:password]
        do {
            let data = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            
            _networkRequest(urlPath: path, params: nil, method: .POST, headers: headers, body: data,
                            onSuccess: {
                                session in
                                successBlock(session)
            },
                            onFailure: {
                                session, error in
                                failureBlock(session, error)
            })
        } catch let jsonError {
            failureBlock(nil, jsonError as NSError)
        }
    }
    
    // MARK: - 2. Get-Balance Service
    func getBalance( _ token: String,
                     onSuccess successBlock: @escaping (BalanceGetter) -> Void,
                     onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        
        let path = NETWORK.PATH.BALANCE
        let headers = [NETWORK.HEADERS.CONTENT_TYPE: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.ACCEPT: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.AUTHORIZATION: token]
        _networkRequest(urlPath: path, params: nil, method: .GET, headers: headers, body: nil,
                        onSuccess: {
                            balanceGetter in
                            successBlock(balanceGetter)
        },
                        onFailure: {
                            session, error in
                            failureBlock(session, error)
        })
    }
    
    // MARK: - 3. Get-Payees Service
    func getPayees( _ token: String,
                    onSuccess successBlock: @escaping (PayeeGetter) -> Void,
                    onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        
        let path = NETWORK.PATH.PAYEES
        let headers = [NETWORK.HEADERS.CONTENT_TYPE: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.ACCEPT: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.AUTHORIZATION: token]
        _networkRequest(urlPath: path, params: nil, method: .GET, headers: headers, body: nil,
                        onSuccess: {
                            payeeGetter in
                            successBlock(payeeGetter)
        },
                        onFailure: {
                            session, error in
                            failureBlock(session, error)
        })
    }
    
    // MARK: - 4. Get-Transactions Service
    func getTransactions( _ token: String,
                          onSuccess successBlock: @escaping (TransactionGetter) -> Void,
                          onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        
        let path = NETWORK.PATH.TRANSACTIONS
        let headers = [NETWORK.HEADERS.CONTENT_TYPE: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.ACCEPT: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.AUTHORIZATION: token]
        _networkRequest(urlPath: path, params: nil, method: .GET, headers: headers, body: nil,
                        onSuccess: {
                            transactionsGetter in
                            successBlock(transactionsGetter)
        },
                        onFailure: {
                            session, error in
                            failureBlock(session, error)
        })
    }
    
    // MARK: - 5. Make-Transfer Service
    func makeTransfer( _ token: String, transfer: Transfer,
                       onSuccess successBlock: @escaping (MakeTransfer) -> Void,
                       onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        
        let path = NETWORK.PATH.TRANSFER
        let headers = [NETWORK.HEADERS.CONTENT_TYPE: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.ACCEPT: NETWORK.HEADERS.APP_JSON,
                       NETWORK.HEADERS.AUTHORIZATION: token]
        do {
            let data = try JSONSerialization.data(withJSONObject: transfer, options: JSONSerialization.WritingOptions.prettyPrinted)
            _networkRequest(urlPath: path, params: nil, method: .POST, headers: headers, body: data,
                            onSuccess: {
                                transferReport in
                                successBlock(transferReport)
            },
                            onFailure: {
                                session, error in
                                failureBlock(session, error)
            })
        } catch let jsonError {
            failureBlock(nil, jsonError as NSError)
        }
    }
    
    //MARK: - supporting functions
    fileprivate func _networkRequest<T1:Decodable, T2:Decodable>(urlPath:String,
                                           params: [String: String]?,
                                           method: HTTPRequestType,
                                           headers: [String: String]?,
                                           body: Data?,
                                           onSuccess successBlock:@escaping (T1)->Void,
                                           onFailure failureBlock:@escaping (T2?, NSError)->Void) {
        networkManager.httpRequest(urlPath,
                                   params: params,
                                   method: method,
                                   headers: headers,
                                   body: body,
                                   onSuccess: { (data) in
                                    
                                    let decoder = JSONDecoder.init()
                                    do {
                                        let transformedData =  try decoder.decode(T1.self, from: data)
                                        successBlock(transformedData)
                                    } catch {
                                        failureBlock(nil, error as NSError)
                                    }
        },
                                   onFailure: { (data, error) in
                                    if data != nil {
                                        let decoder = JSONDecoder.init()
                                        do {
                                            let transformedData =  try decoder.decode(T2.self, from: data!)
                                            failureBlock(transformedData, error)
                                        } catch {
                                            failureBlock(nil, error as NSError)
                                        }
                                    } else {
                                        failureBlock(nil, error)
                                    }
        })
    }
}
