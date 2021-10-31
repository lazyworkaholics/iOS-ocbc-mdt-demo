//
//  TransferViewModel.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import XCTest
@testable import OCBCDemo

class TransferViewModelTests: XCTestCase {

    // This function tests the login view model initialization...
    func testDashboardViewModelInit() {
        let viewmodel = TransferViewModel.init()
        XCTAssertNotNil(viewmodel.router)
    }
    
    // When user clicks send button without filling the mandatory fields with valid data
    // Alerts should be shown to the users where and when they are necessary
    // This function tests if the alerts are shown are not...
    func test_getDashboardData_failure() {
        var viewmodel = TransferViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = false

        // 1. if amount or account are nil
//        mockServiceManager.mock_error_session = Session.init(status: .failed, token: nil, failureDescription: "Test failure description")
//        mockServiceManager.mock_error = NSError.init(domain: "com.testError", code: 1001, userInfo: nil)
//        viewmodel.serviceManager = mockServiceManager
//        DataManager.apiToken = "Test_API_Token"
        
        viewmodel.onTransferClick()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
        // 3. account number lessthan 8digits
        viewmodel.setAccountNumber("123")
        viewmodel.setAmount(34)
        mockServiceManager.isServiceCallSuccess = false
        viewmodel.onTransferClick()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
        // 2. description nil
        viewmodel.setAccountNumber("12345678")
        mockServiceManager.isServiceCallSuccess = false
        viewmodel.onTransferClick()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
        // 4. showing alert
        viewmodel.setDescription("test")
        mockServiceManager.isServiceCallSuccess = false
        viewmodel.onTransferClick()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
    }
    
    // when transferViewmodel router handler functions are invoked, they should inturn invoke router's respective func
    // this function tests if these events are happening or not...
    func test_router_handlers() {
        
        var viewmodel = TransferViewModel.init()
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        viewmodel.logout()
        XCTAssertTrue(mockRouter.is_logout_called)
        
        viewmodel.back()
        XCTAssertTrue(mockRouter.is_gohome_called)
    }
    
    // when dashboardviewmodel data handler functions are invoked, they should return data from Datamanager
    // this function tests if these events are happening or not...
    func test_data_handlers() {
        DataManager.balanceGetter = BalanceGetter.init(status: .success, balance: 100, failureDescription: nil)
        DataManager.payeeGetter = PayeeGetter.init(status: .success, payees: [], failureDescription: nil)
        DataManager.transactionGetter = TransactionGetter.init(status: .success, transactions: [], failureDescription: nil)
        
        var viewmodel = TransferViewModel.init()
        XCTAssertEqual(viewmodel.getAccountName(), LITERAL.ACCOUNT_NO)
        XCTAssertEqual(viewmodel.getAccountNumber(), "")
    }
    
    // when makeTransfer is invoked with transfer object, on success user should be notified of the event with alert
    // This function tests if this event is happening or not...
    func test_makeTransfer() {
        var viewmodel = TransferViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = true
        
        DataManager.apiToken = "test_token"
        mockServiceManager.mock_MakeTransfer = MakeTransfer.init(status: .success, response: Transfer.init(with: 200, recipientAccountNo: "Test Account", dateString: "test date", description: "test desc"), failureDescription: nil)
        viewmodel.serviceManager = mockServiceManager
        viewmodel.makeTransfer(Transfer.init(with: 200, recipientAccountNo: "test", dateString: "test", description: "test"))
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
    }
    
    // when makeTransfer is invoked with invalid transfer object, on failure, user should be notified of the event with alert
    // This function tests if this event is happening or not...
    func test_makeTransfer_failure() {
        var viewmodel = TransferViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = false
        
        DataManager.apiToken = "test_token"
        mockServiceManager.mock_error_session = Session.init(status: .success, token: "test_token", failureDescription: nil)
        mockServiceManager.mock_error = NSError.init(domain: "com.testError", code: 1001, userInfo: nil)
        viewmodel.serviceManager = mockServiceManager
        
        viewmodel.makeTransfer(Transfer.init(with: 200.00, recipientAccountNo: "test", dateString: "test", description: "test"))
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
    }
}
