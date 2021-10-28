//
//  NetworkManagerTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class NetworkManagerTests: XCTestCase {
    
    var networkManagerToTest: NetworkManager?
    override func setUpWithError() throws {
        networkManagerToTest = NetworkManager.init("test_url")
    }
    override func tearDownWithError() throws {
        let defaultConfiguration = URLSessionConfiguration.default
        networkManagerToTest?.urlSession = URLSession.init(configuration: defaultConfiguration)
    }

    // When a service returns any status code apart from that of success,
    // failure block should be invoked with the error constructed from the respective status
    // This function tests whether failure block invoked with the respective error or not
    func testInternalServerError() {
        let mockSession = URLSessionMock()
        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 500,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test",
                                          params: [:],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is an internal server error.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(500, error.code, "Error object should return error code 500")
        })
    }
    
    // When there is no internet connection, failure block should be invoked with no-internet error
    // This function tests whether the failure block invoked with the no-internet error or not
    func testNoInternetConnection() {
        networkManagerToTest?.isConnectedToNetwork = false
        networkManagerToTest?.httpRequest("test",
                                          params: nil,
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: { (
                                            responseData) in
                                            XCTFail("Success block should not be called if there is no network connection.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(ERROR.NO_INTERNET.CODE, error.code, "Error object should return error code 1009")
        })
    }
    
    // When a service returns success with parsable data, success block should be invoked
    // This function tests the succes block invoked or not
    func testSuccessCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        let mockResponseData = Data.init(base64Encoded:"VGhpcyBpcyBub3QgYSBKU09O")
        mockSession.data = mockResponseData
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066", "bia":"1068"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTAssertEqual(responseData, mockResponseData, "response data is mismatched")
        },
                                          onFailure: { (error) in
                                            XCTFail("Error should not be received for this success scenario")
                                            
        })
    }
    
    // When a service returns success, with nil data, failure block should be invoked with a parsing error
    // This function tests the failure block invoked with the respective error or not
    // Note - such case should not happen in a realtime scenario...
    // But if happened, inform about this bug to your respective microservices team...
    func testNilResponseDataReceiverCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is no data in response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(ERROR.PARSING.CODE, error.code, "Error object should return error code 1010")
        })
    }
    
    // When a service returns any status code apart from that of success,
    // failure block should be invoked with the error constructed from the respective status
    // This function tests whether failure block invoked with the respective error or not
    func testNon200StatusReceiverCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        mockSession.data = nil
        mockSession.response = HTTPURLResponse.init(url: URL.init(string:"https://www.google.com")! ,
                                                    statusCode: 400,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        mockSession.error = nil
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881"],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if the status code is non 200s")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(400, error.code, "Error object should return error code 400 as specified above")
        })
    }
    
    // When a service returned response is not convertable to HTTPURLResponse, such case should be considered as a parsing error though
    // This function tests whether failure block invoked with the respective parsing error or not
    // Note - such case should not happen in a realtime scenario...
    // But if happened, report the bug to APPLE Inc.
    func testNilResponseReceiverCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data("test_data".utf8)
        mockSession.data = nil
        mockSession.response = nil
        mockSession.error = nil
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: ["Header1":"headerValue"],
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is no response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(ERROR.PARSING.CODE, error.code, "Error object should return error code 1010")
        })
    }
    
    // When service returns an error, invoke failure block with the same error
    // This function tests whether the error block invoked with the same error or not
    func testErrorReceiverCase() {
        let mockSession = URLSessionMock()
        let mockRequestData = Data.init(base64Encoded:"tahfahfhfaisfhaihf")
        mockSession.data = nil
        mockSession.response = nil
        let error1 = NSError.init(domain: "custom error", code: 1, userInfo: nil)
        mockSession.error = error1
        networkManagerToTest?.urlSession = mockSession
        networkManagerToTest?.isConnectedToNetwork = true
        networkManagerToTest?.httpRequest("test/test2",
                                          params: ["biw":"1881", "bih":"1066"],
                                          method: HTTPRequestType.GET,
                                          headers: ["header1":"header"],
                                          body: mockRequestData,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is error in response.")
        },
                                          onFailure: { (error) in
                                            XCTAssertEqual(error1, error, "Error object should match as specified above")
        })
    }

    // When a service request is not valide,
    // failure block should be invoked with an invalid request error
    // This function tests whether failure block invoked with the respective error or not
    func testNoBaseURLError() {
        networkManagerToTest?.baseURL = nil
        networkManagerToTest?.httpRequest("test",
                                          params: [:],
                                          method: HTTPRequestType.GET,
                                          headers: nil,
                                          body: nil,
                                          onSuccess: {
                                            (responseData) in
                                            XCTFail("Success block should not be called if there is an internal server error.")
        },
                                          onFailure: {
                                            (error) in
                                            XCTAssertEqual(ERROR.INVALID_REQUEST.CODE, error.code, "Error object should return error code 500")
        })
    }
}
