//
//  NetworkManager.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//
import Foundation
import SystemConfiguration

enum HTTPRequestType:String {
    case GET
    case POST
    case PUT
    case DELETE
}

struct NetworkManager: NetworkManagerProtocol
{
    // MARK: - variables and initializers
    var baseURL:String?
    var urlSession:URLSession
    var isConnectedToNetwork:Bool
    
    @available(*, unavailable, message: "use init(baseURL:) instead")
    init() { fatalError() }
    
    init(_ baseURL:String?) {
        self.baseURL = baseURL
        self.urlSession = URLSession.init(configuration: URLSessionConfiguration.default)
        self.isConnectedToNetwork = NetworkManager._updateNetworkConnection()
    }
    
    // http request function that handles the core networking with backend server
    func httpRequest(_ urlPath: String,
                     params: [String : String]?,
                     method: HTTPRequestType,
                     headers: [String : String]?,
                     body: Data?,
                     onSuccess successBlock: @escaping (Data) -> Void,
                     onFailure failureBlock: @escaping (NSError) -> Void) {
        // check if the device has internet connectivity, either through wifi or cellular
        if isConnectedToNetwork {
            guard let urlRequest = _requestConstructor(urlPath, params: params, method: method, headers: headers, body: body) else {
                // If the request is not valid.
                let errorObject = self._errorConstructor(ERROR.INVALID_REQUEST.DOMAIN, code: ERROR.INVALID_REQUEST.CODE, description: ERROR.INVALID_REQUEST.DESCRIPTION)
                failureBlock(errorObject)
                return
            }
            _sessionDataTask(urlRequest, onSuccess: successBlock, onFailure: failureBlock)
        }
        else {
            // If no internet to make a call, invoke the nonetwork error.
            let errorObject = self._errorConstructor(ERROR.NO_INTERNET.DOMAIN, code: ERROR.NO_INTERNET.CODE, description: ERROR.NO_INTERNET.DESCRIPTION)
            failureBlock(errorObject)
        }
    }
    
    // MARK: - core function to handle Network dataTask with URLSession
    // calls and validates the network response
    // with appropriate success and failure blocks
    fileprivate func _sessionDataTask(_ urlRequest:URLRequest,
                     onSuccess successBlock:@escaping (Data)->Void,
                     onFailure failureBlock:@escaping (NSError)->Void) {
        // urlsession's dataTask function call to fetch response from backent
        let dataTask = urlSession.dataTask(with: urlRequest) {
            (responseData, urlResponse, error) in
            
            if error == nil {
                if let urlResponse = urlResponse as? HTTPURLResponse {
                    //The API call was successful, go ahead and parse the data
                    if urlResponse.statusCode >= 200 && urlResponse.statusCode <= 206 {
                        if let responseData = responseData {
                            //happy path - API Call and Parsing, both went successful.
                            //so invoke success block, with parsed data.
                            //Note - this is the only place where success block can be invoked.
                            successBlock(responseData)
                        }
                        else {
                            // Oops we should never get here in the first place. Abort!!
                            // api call returned success code, but the data is not parsable.
                            // such case should never exist.
                            // something wrong on microservices - report to the respective team.
                            let errorObject = self._errorConstructor(ERROR.PARSING.DOMAIN, code: ERROR.PARSING.CODE, description: ERROR.PARSING.DESCRIPTION)
                            failureBlock(errorObject)
                        }
                    } else {
                        // if api call returns any other status code apart from success,
                        // construct the respective error and invoke the failure block
                        let errorObject = self._errorConstructor(ERROR.HTTPURLRESPONSE.DOMAIN, code: urlResponse.statusCode, description: HTTPURLResponse.localizedString(forStatusCode: urlResponse.statusCode))
                        failureBlock(errorObject)
                    }
                } else {
                    // Oops we should never get here in the first place. Abort!!
                    // URLResponse is not convertable to HTTPURLResponse - such case should never exist.
                    // Report this bug to APPLE team.
                    let errorObject = self._errorConstructor(ERROR.PARSING.DOMAIN, code: ERROR.PARSING.CODE, description: ERROR.PARSING.DESCRIPTION)
                    failureBlock(errorObject)
                }
            } else {
                // if api call returned an error
                // invoke failure block with the same error
                failureBlock(error! as NSError)
            }
        }
        dataTask.resume()
    }
    // MARK: - private helper functions
    // helper function to construct a urlRequest from given path, parameters, body etc
    fileprivate func _requestConstructor(_ urlPath:String,
                                     params: [String: String]?,
                                     method: HTTPRequestType,
                                     headers: [String: String]?,
                                     body: Data?) -> URLRequest? {
        // 1. Base URL
        guard (baseURL != nil) else {
            return nil
        }
        var url = URL.init(string: baseURL!)
        // 2. Service Path
        var relativePath = urlPath
        // 3. URL Parameters
        if params != nil {
            relativePath = relativePath + "?"
            var isFirstIteration:Bool = true
            for (key, value) in params! {
                if !isFirstIteration {
                    relativePath = relativePath + "&"
                }
                relativePath = relativePath + key + "=" + value
                isFirstIteration = false
            }
        }
        url = URL.init(string: url!.appendingPathComponent(relativePath) .absoluteString.removingPercentEncoding!)!
        var urlRequest = URLRequest.init(url:url!,
                                         cachePolicy: .useProtocolCachePolicy,
                                         timeoutInterval:60.0)
        urlRequest.httpMethod = method.rawValue
        // 4. Request Body
        if body != nil {
            urlRequest.httpBody = body
        }
        // 5. Request Headers
        for (key, value) in headers ?? [:] {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
    // helper function to construct an error object from domain code and description
    private func _errorConstructor(_ domain:String, code:Int, description:String) -> NSError
    {
        let error = NSError.init(domain: domain, code: code, userInfo: [NSLocalizedDescriptionKey: description])
        return error
    }
    
    // helper function to check the presence of network to the device
    private static func _updateNetworkConnection() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
            
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
