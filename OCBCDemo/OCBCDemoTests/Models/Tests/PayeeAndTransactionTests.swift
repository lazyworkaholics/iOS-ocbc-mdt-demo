//
//  PayeeAndTransactionTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import XCTest
@testable import OCBCDemo

class PayeeAndTransactionTests: XCTestCase {
    // when a non parsable data is passed PayeeGetter's init - it should throw an exception
    // This function tests for the trowing of exception in such case
    func test_payeeGetter_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(PayeeGetter.self, from: utf8str!)
            XCTFail("init should not create a PayeeGetter object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed payeeGetter's init - should return payeeGetter object with .success status
    // This function tests whether the .status is success or not
    func test_payeeGetter_with_balance() {
        let utf8str = "{\"status\": \"success\", \"data\": [{\"id\": \"8a6da1a4-6f5f-4b53-9b90-0f8c57661a5d\", \"accountNo\": \"8013-777-3232\", \"accountHolderName\": \"Jason\"},{\"id\": \"19bbc716-ddc3-48d1-a6f9-bb7b96749826\", \"accountNo\": \"4489-991-0023\", \"accountHolderName\": \"Jane\" }]}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let payeeGetter = try decoder.decode(PayeeGetter.self, from: utf8str!)
            XCTAssertEqual(payeeGetter.status, .success, "with the given data status should be success")
            XCTAssertEqual(payeeGetter.payees?.count, 2)
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when an invalid failed data is passed payeeGetter's init - should return an object with .failed status
    // This function tests whether the .status is failed or not
    func test_payeeGetter_with_failure() {
        let utf8str = "{\"status\":\"failed\", \"description\": \"Invalid username or password\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let payeeGetter = try decoder.decode(BalanceGetter.self, from: utf8str!)
            XCTAssertEqual(payeeGetter.status, .failed, "with the given data status should be failed")
            XCTAssertEqual(payeeGetter.failureDescription, "Invalid username or password")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when a non parsable data is passed TransactionGetter's init - it should throw an exception
    // This function tests for the trowing of exception in such case
    func test_transactionGetter_invalidData() {
        let utf8str = "testData".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            _ = try decoder.decode(TransactionGetter.self, from: utf8str!)
            XCTFail("init should not create a PayeeGetter object with this invalid data")
        } catch {
            XCTAssert(true)
        }
    }
    
    // when a valid success data is passed transactionGetter's init - should return an object with .success status
    // This function tests whether the .status is success or not
    func test_transactionGetter_with_balance() {
        let utf8str = "{\"status\": \"success\", \"data\": [{\"id\": \"39222a3e-3890-4091-8807-d92707355f8c\",  \"type\": \"receive\",  \"amount\": 18.5, \"currency\": \"SGD\",  \"from\": { \"accountNo\": \"1234-000-1234\", \"accountHolderName\": \"Max Yee\"}, \"description\": null, \"date\": \"2021-09-12T02:13:03.054Z\"}, {\"id\": \"39222a3e-3890-4091-8807-d92707355f8c4\",  \"type\": \"transfer\",  \"amount\": 18.5,  \"currency\": \"SGD\",  \"to\": { \"accountNo\": \"1234-000-1234\", \"accountHolderName\": \"Max Yee\"}, \"description\": null, \"date\": \"2021-09-12T02:13:03.054Z\"}]}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let transactionGetter = try decoder.decode(TransactionGetter.self, from: utf8str!)
            XCTAssertEqual(transactionGetter.status, .success, "with the given data status should be success")
            XCTAssertEqual(transactionGetter.transactions?.count, 2)
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
    
    // when an invalid failed data is passed transactionGetter's init - should return an object with .failed status
    // This function tests whether the .status is failed or not
    func test_transactionGetter_with_failure() {
        let utf8str = "{\"status\":\"failed\", \"description\": \"Invalid username or password\"}".data(using: .utf8)
        do {
            let decoder = JSONDecoder.init()
            let transactionGetter = try decoder.decode(TransactionGetter.self, from: utf8str!)
            XCTAssertEqual(transactionGetter.status, .failed, "with the given data status should be failed")
            XCTAssertEqual(transactionGetter.failureDescription, "Invalid username or password")
        } catch {
            XCTFail("the given data to coder is valid, should not raise exception here")
        }
    }
}
