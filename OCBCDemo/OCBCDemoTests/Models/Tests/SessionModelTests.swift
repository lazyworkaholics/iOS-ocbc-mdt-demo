//
//  ServiceStatusTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class SessionModelTests: XCTestCase {
    // when a non parsable data is passed Session's init - it should throw an exception
    // This function tests for the trowing of exception in such case...
    func testSession_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(Session.self, from: utf8str!)
            XCTFail("init with coder should not create a Session object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed session's init - should return session object with .success status
    // This function tests whether the session.status is success or not...
    func testSession_with_token() {
        let utf8str = "{\"status\":\"success\", \"token\": \"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..gBsfbCL01IkpMuIlDC-\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let session = try decoder.decode(Session.self, from: utf8str!)
            XCTAssertEqual(session.status, .success, "with the given data status should be success")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when an invalid failed data is passed session's init - should return a session object with .failed status
    // This function tests whether the session.status is failed or not...
    func testSession_with_failure() {
        let utf8str = "{\"status\":\"failed\", \"description\": \"Invalid username or password\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let session = try decoder.decode(Session.self, from: utf8str!)
            XCTAssertEqual(session.status, .failed, "with the given data status should be failed")
            XCTAssertEqual(session.failureDescription, "Invalid username or password")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }

    // when a non parsable data is passed ServiceStatus's init - it should throw an exception
    // This function tests for the trowing of exception in such case...
    func testServiceStatus_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(ServiceStatus.self, from: utf8str!)
            XCTFail("init with coder should not create a ServiceStatus object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed ServiceStatus's init - should return .success
    // This function tests whether the value is success or not...
    func testServiceStatus_failed_status() {
        let utf8str = "{\"status\": \"failed\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let serviceStatus = try decoder.decode(ServiceStatus.self, from: utf8str!)
            XCTAssertEqual(serviceStatus, .failed, "with the given data status should be failed")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when a non parsable data is passed BalanceGetter's init - it should throw an exception
    // This function tests for the trowing of exception in such case...
    func test_balanceGetter_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(BalanceGetter.self, from: utf8str!)
            XCTFail("init should not create a BalanceGetter object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed balanceGetter's init - should return balanceGetter object with .success status
    // This function tests whether the .status is success or not...
    func test_balanceGetter_with_balance() {
        let utf8str = "{\"status\":\"success\", \"balance\": 100000}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let balanceGetter = try decoder.decode(BalanceGetter.self, from: utf8str!)
            XCTAssertEqual(balanceGetter.status, .success, "with the given data status should be success")
            XCTAssertEqual(balanceGetter.balance, 100000)
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when an invalid failed data is passed balanceGetter's init - should return an object with .failed status
    // This function tests whether the .status is failed or not...
    func test_balanceGetter_with_failure() {
        let utf8str = "{\"status\":\"failed\", \"description\": \"Invalid username or password\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let balanceGetter = try decoder.decode(BalanceGetter.self, from: utf8str!)
            XCTAssertEqual(balanceGetter.status, .failed, "with the given data status should be failed")
            XCTAssertEqual(balanceGetter.failureDescription, "Invalid username or password")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
}
