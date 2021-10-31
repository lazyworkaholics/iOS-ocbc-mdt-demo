//
//  DashboardViewModelTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import XCTest
@testable import OCBCDemo

class DashboardViewModelTests: XCTestCase {

    // This function tests the login view model initialization...
    func testDashboardViewModelInit() {
        let viewmodel = DashboardViewModel.init()
        XCTAssertNotNil(viewmodel.router)
    }
    
    // when getDashboardData is invoked successfully,
    //      1. api returns a valid balanceGetter, payeeGetter and transactionGetter
    // This function tests if this events are happening or not...
    func test_getDashboardData_success() {
        var viewmodel = DashboardViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = true
        DataManager.apiToken = "Test_API_Token"
        
        let balanceGetter_mock = BalanceGetter.init(status: .success, balance: 100, failureDescription: nil)
        let payeeGetter_mock = PayeeGetter.init(status: .success, payees: [], failureDescription: nil)
        let transactionGetter_mock = TransactionGetter.init(status: .success, transactions: [], failureDescription: nil)
        
        mockServiceManager.mock_balanceGetter = balanceGetter_mock
        mockServiceManager.mock_PayeeGetter = payeeGetter_mock
        mockServiceManager.mock_TransactionGetter = transactionGetter_mock

        viewmodel.serviceManager = mockServiceManager
        
        viewmodel.getDashboardData()
        
        XCTAssertEqual(DataManager.balanceGetter?.balance, balanceGetter_mock.balance)
        XCTAssertEqual(DataManager.payeeGetter?.status, payeeGetter_mock.status)
        XCTAssertEqual(DataManager.transactionGetter?.transactions?.count, transactionGetter_mock.transactions?.count)
        XCTAssertTrue(mockDelegate.is_reloadData_called)
    }
    
    // when getDatashboardData is invoked and failed,
    //      1. alert should be fired from delegate
    // This function tests if this event is happening or not...
    func test_getDashboardData_failure() {
        var viewmodel = DashboardViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = false

        mockServiceManager.mock_error_session = Session.init(status: .failed, token: nil, failureDescription: "Test failure description")
        mockServiceManager.mock_error = NSError.init(domain: "com.testError", code: 1001, userInfo: nil)
        viewmodel.serviceManager = mockServiceManager
        
        DataManager.apiToken = "Test_API_Token"
        viewmodel.getDashboardData()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
        mockServiceManager.mock_error_session = nil
        viewmodel.serviceManager = mockServiceManager
        viewmodel.getDashboardData()
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
    }
    
    // when dashboardViewmodel router handler functions are invoked, they should inturn invoke router's respective func
    // this function tests if these events are happening or not...
    func test_router_handlers() {
        
        var viewmodel = DashboardViewModel.init()
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        viewmodel.logout()
        XCTAssertTrue(mockRouter.is_logout_called)
        
        viewmodel.onTransferClick()
        XCTAssertTrue(mockRouter.is_navigateToTransferView_called)
    }
    
    // when dashboardviewmodel data handler functions are invoked, they should return data from Datamanager
    // this function tests if these events are happening or not...
    func test_data_handlers() {
        DataManager.balanceGetter = BalanceGetter.init(status: .success, balance: 100, failureDescription: nil)
        DataManager.payeeGetter = PayeeGetter.init(status: .success, payees: [], failureDescription: nil)
        DataManager.transactionGetter = TransactionGetter.init(status: .success, transactions: [], failureDescription: nil)
        
        let viewmodel = DashboardViewModel.init()
        XCTAssertEqual(viewmodel.getBalance(), "SGD 100.00")
        XCTAssertEqual(viewmodel.getPayeeCount(), 0)
        XCTAssertEqual(viewmodel.getAllPayees().count, 0)
        XCTAssertEqual(viewmodel.getTransactionsCount(), 0)
    }
}
