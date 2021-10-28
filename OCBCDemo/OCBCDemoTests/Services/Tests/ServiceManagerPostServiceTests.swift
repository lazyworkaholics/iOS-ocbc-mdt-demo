//
//  ServiceManagerTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class ServiceManagerPostServiceTests: XCTestCase {

    var serviceManagerToTest:ServiceManager?
    var mockNetworkManager:NetworkManagerMock?
    
    var mockSession:Session?
    var testError:NSError?
    
    override func setUpWithError() throws {
        
        let text = "{\"status\": \"success\", \"token\": \"bf813u4918hf\"}"
        let utf8str = text.data(using: .utf8)
        let decoder = JSONDecoder.init()
        mockSession = try! decoder.decode(Session.self, from: utf8str!)
        
        testError = NSError.init(domain: "com.testingErrorDomain",
                                 code: 11010101843834,
                                 userInfo: [NSLocalizedDescriptionKey:"Mock constructed Error"])
        serviceManagerToTest = ServiceManager.init()
        mockNetworkManager = NetworkManagerMock.init()
        mockNetworkManager?.data = text.data(using: .utf8)
        mockNetworkManager?.error = testError
    }

    override func tearDownWithError() throws {
        mockSession = nil
        testError = nil
        mockNetworkManager = nil
        serviceManagerToTest = nil
    }
    
    // Login Service - when network manager returns an error to login service...
    func test_login_failed() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.login("*****", password: "*****", onSuccess: {
            session in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertEqual(error, self.testError!, "login function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    // Login Service - when network manager returns a success block...
    func test_login_ValidResponse() {
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.login("*****", password: "*****", onSuccess: {
            session in
            XCTAssertEqual(session.status, .success, "failed to parse the given data into required model")
        }, onFailure: {
            session, error in
            XCTFail("Failure block should not be called when network manager returns a valid data.")
        })
    }
    
    // Login Service - when network manager returns a failure block with a nil Session...
    func test_login_invalidData() {
        mockNetworkManager?.isSuccess = true
        mockNetworkManager?.data = "WrongData-invalide Case".data(using: .utf8)
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.login("*****", password: "*****", onSuccess: {
            session in
            XCTFail("Success block should not be called when the data is  not in valid format")
        }, onFailure: {
            session, error in
            XCTAssertTrue(true)
        })
    }
    
    // Login Service - when network manager returns a failure block with a valid Session and error...
    func test_login_invalidData2() {
        mockNetworkManager?.isSuccess = false
        mockNetworkManager?.error_data = "{\"status\": \"failed\", \"description\": \"bf813u4918hf\"}".data(using: .utf8)
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.login("*****", password: "*****", onSuccess: {
            session in
            XCTFail("Success block should not be called when the data is  not in valid format")
        }, onFailure: {
            session, error in
            XCTAssertTrue(true)
        })
    }
    
    // Make Transfer Service - when network manager returns an error to login service...
    func test_makeTransfer_failed() {
        mockNetworkManager?.isSuccess = false
        serviceManagerToTest?.networkManager = mockNetworkManager!
        serviceManagerToTest?.makeTransfer("*****", transfer: Transfer.init(with: 200, recipientAccountNo: "***", dateString: "2021-09-12T00:00:00.000Z",  description: "***"), onSuccess: {
            session in
            XCTFail("Success block should not be called if there is an internal network error.")
        }, onFailure: {
            session, error in
            XCTAssertEqual(error, self.testError!, "login function is not returning the exact error as retured by NetworkManager")
        })
    }
    
    // Make Transfer Service - when network manager returns a success block...
    func test_makeTransfer_pass() {
        mockNetworkManager?.isSuccess = true
        serviceManagerToTest?.networkManager = mockNetworkManager!
        mockNetworkManager?.data = "{\"status\":\"success\", \"data\":{\"id\":\"2d6a58fb-f779-47d4-9fa0-4c3a889ae96e\", \"recipientAccountNo\":\"4992-992-9021\", \"amount\":100, \"date\": \"2021-09-12T00:00:00.000Z\", \"description\": \"room rent\"}}".data(using: .utf8)
        serviceManagerToTest?.makeTransfer("*****", transfer: Transfer.init(with: 200, recipientAccountNo: "***", dateString: "2021-09-12T00:00:00.000Z",  description: "***"), onSuccess: {
            makeTransfer in
            XCTAssertEqual(makeTransfer.status, .success, "failed to parse the given data into required model")
        }, onFailure: {
            session, error in
            XCTFail("Failure block should not be called when network manager returns a valid data.")
        })
    }
}
