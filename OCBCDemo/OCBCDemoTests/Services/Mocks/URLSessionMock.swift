//
//  ServicesMock.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation
@testable import OCBCDemo

class URLSessionMock: URLSession {

    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
        
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let response = self.response
        let error = self.error
        
        completionHandler(data, response, error)
        return URLSession.init(configuration:  URLSessionConfiguration.default).dataTask(with: request)
    }
}
