//
//  NetworkManagerMock.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation
@testable import OCBCDemo

class NetworkManagerMock: NetworkManagerProtocol {
    
    var baseURL: String? = "test_url"
    var urlSession: URLSession = URLSession.init(configuration: URLSessionConfiguration.default)
    var isConnectedToNetwork: Bool = true
    
    var data: Data?
    var error: NSError?
    var error_data: Data?
    var isSuccess: Bool?
    
    func httpRequest(_ urlPath: String, params: [String : String]?, method: HTTPRequestType, headers: [String : String]?, body: Data?, onSuccess successBlock: @escaping (Data) -> Void, onFailure failureBlock: @escaping (Data?, NSError) -> Void) {
        if isSuccess!
        {
            successBlock(data!)
        }
        else
        {
            failureBlock(error_data, error!)
        }
    }
}
