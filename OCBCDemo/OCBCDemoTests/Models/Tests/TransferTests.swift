//
//  TransferTests.swift
//  OCBCDemoTests
//
//  Created by Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class TransferTests: XCTestCase {
    // when a non parsable data is passed MakeTransfer's init - it should throw an exception
    // This function tests for the trowing of exception in such case
    func test_transfer_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(MakeTransfer.self, from: utf8str!)
            XCTFail("init with coder should not create a Session object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed makeTransfer's init - should return an object with .success status
    // This function tests whether the .status is success or not
    func test_transfer_successCase() {
        let utf8str = "{\"status\":\"success\", \"data\":{\"id\":\"2d6a58fb-f779-47d4-9fa0-4c3a889ae96e\", \"recipientAccountNo\":\"4992-992-9021\", \"amount\":100, \"date\": \"2021-09-12T00:00:00.000Z\", \"description\": \"room rent\"}}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let transfer = try decoder.decode(MakeTransfer.self, from: utf8str!)
            XCTAssertEqual(transfer.status, .success, "with the given data status should be success")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when an invalid failed data is passed makeTransfer's init - should return an object with .failed status
    // This function tests whether the .status is failed or not
    func test_makeTransfer_with_failure() {
        let utf8str = "{\"status\":\"failed\", \"description\": \"Invalid username or password\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let makeTransfer = try decoder.decode(MakeTransfer.self, from: utf8str!)
            XCTAssertEqual(makeTransfer.status, .failed, "with the given data status should be failed")
            XCTAssertEqual(makeTransfer.failureDescription, "Invalid username or password")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when Transfer's init is invoked with valid parameter, init should return a valid transfer object
    // This function tests for the transfers init
    func test_transfer_init() {
        let transfer = Transfer.init(with: 200, recipientAccountNo: "TestAccountNo", dateString: "testDate", description: "testDescription")
        XCTAssertNotNil(transfer)
    }
}
