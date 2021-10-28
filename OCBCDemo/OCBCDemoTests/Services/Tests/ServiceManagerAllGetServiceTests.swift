//
//  ServiceManagerAllGetServiceTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class ServiceManagerAllGetServiceTests: XCTestCase {
    
    var serviceManagerToTest:ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    
    var error_data:Data?
    var testError:NSError?
    
    override func setUpWithError() throws {
        error_data = "{\"status\": \"failed\", \"status\": \"bf813u4918hf\"}".data(using: .utf8)
        testError = NSError.init(domain: "com.testingErrorDomain", code: 11010101843834, userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        
        serviceManagerToTest = ServiceManager.init()
        mockNetworkManager = NetworkManagerMock.init()
    }

    override func tearDownWithError() throws {
        error_data = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest = nil
    }
    
    // GetBalance Service - when network manager returns an error...
    func test_getBalance_failed() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.error = testError
        mockNetworkManager?.error_data = error_data
        
        serviceManagerToTest?.getBalance("*****", onSuccess: {
            balanceGetter in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertEqual(error, self.testError!, "get balance function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    // GetBalance Service - when network manager returns a success block...
    func test_getBalance_Pass() {
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.data = "{\"status\": \"success\", \"balance\": 448}".data(using: .utf8)
        serviceManagerToTest?.getBalance("*****", onSuccess: {
            balanceGetter in
            XCTAssertEqual(balanceGetter.status, .success, "failed to parse the given data into required model")
        }, onFailure: {
            session, error in
            XCTFail("Failure block should not be called when network manager returns a valid data.")
        })
    }
    
    // GetPayees Service - when network manager returns an error...
    func test_getPayees_failed() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.error = testError
        mockNetworkManager?.error_data = error_data
        
        serviceManagerToTest?.getPayees("*****", onSuccess: {
            payeeGetter in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertEqual(error, self.testError!, "get balance function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    // GetPayees Service - when network manager returns a success block...
    func test_getPayees_Pass() {
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.data = "{\"status\": \"success\", \"data\": [{\"id\": \"8a6da1a4-6f5f-4b53-9b90-0f8c57661a5d\", \"accountNo\": \"8013-777-3232\", \"accountHolderName\": \"Jason\"},{\"id\": \"19bbc716-ddc3-48d1-a6f9-bb7b96749826\", \"accountNo\": \"4489-991-0023\", \"accountHolderName\": \"Jane\" }]}".data(using: .utf8)
        serviceManagerToTest?.getPayees("*****", onSuccess: {
            payeeGetter in
            XCTAssertEqual(payeeGetter.status, .success, "failed to parse the given data into required model")
        }, onFailure: {
            session, error in
            XCTFail("Failure block should not be called when network manager returns a valid data.")
        })
    }
    
    // GetTransactions Service - when network manager returns an error...
    func test_getTransactions_failed() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.error = testError
        mockNetworkManager?.error_data = error_data
        
        serviceManagerToTest?.getTransactions("*****", onSuccess: {
            transactionGetter in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertEqual(error, self.testError!, "getTransactions function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    // GetTransactions Service - when network manager returns a success block...
    func test_getTransactions_Pass() {
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.data = "{\"status\": \"success\", \"data\": [{\"id\": \"39222a3e-3890-4091-8807-d92707355f8c\",  \"type\": \"receive\",  \"amount\": 18.5, \"currency\": \"SGD\",  \"from\": { \"accountNo\": \"1234-000-1234\", \"accountHolderName\": \"Max Yee\"}, \"description\": null, \"date\": \"2021-09-12T02:13:03.054Z\"}, {\"id\": \"39222a3e-3890-4091-8807-d92707355f8c4\",  \"type\": \"transfer\",  \"amount\": 18.5,  \"currency\": \"SGD\",  \"to\": { \"accountNo\": \"1234-000-1234\", \"accountHolderName\": \"Max Yee\"}, \"description\": null, \"date\": \"2021-09-12T02:13:03.054Z\"}]}".data(using: .utf8)
        serviceManagerToTest?.getTransactions("*****", onSuccess: {
            transactionsGetter in
            XCTAssertEqual(transactionsGetter.status, .success, "failed to parse the given data into required model")
        }, onFailure: {
            session, error in
            XCTFail("Failure block should not be called when network manager returns a valid data.")
        })
    }
    
    // GetTransactions Service - when network manager returns an error with not transformable session value...
    func test_getTransactions_failed_session_nil() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.error = testError
        mockNetworkManager?.error_data = "invalid_data".data(using: .utf8)
        
        serviceManagerToTest?.getTransactions("*****", onSuccess: {
            transactionGetter in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertNil(session)
        })
    }
}
