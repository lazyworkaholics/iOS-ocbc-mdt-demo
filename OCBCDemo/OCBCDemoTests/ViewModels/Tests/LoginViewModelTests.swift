//
//  LoginViewModelTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import XCTest
@testable import OCBCDemo

class LoginViewModelTests: XCTestCase {

    // This function tests the login view model initialization...
    func testLoginViewModelInit() {
        let viewmodel = LoginViewModel.init()
        XCTAssertNotNil(viewmodel.router)
    }
    
    // when loginViewModel's notUsername is called, delagate's relaod data should be fired
    // This function tests if this events is happening or not...
    func test_notUsername() {
        var viewmodel = LoginViewModel.init()
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        viewmodel.notUsername()
        XCTAssertTrue(mockDelegate.is_reloadData_called)
    }
    
    // when a preloaded username is available, this function should return that username else return a nil object.
    // This function tests if these two events are happening or not...
    func test_getUsername() {
        let userdefaults = UserDefaults.standard
        let mock_username = "mockUsername"
        userdefaults.set(mock_username, forKey: "stored_username")
        
        var viewmodel = LoginViewModel.init()
        XCTAssertEqual(viewmodel.getUsername(), mock_username)
        
        userdefaults.removeObject(forKey: "stored_username")
        XCTAssertNil(viewmodel.getUsername())
        
        viewmodel.notUsername()
        XCTAssertNil(viewmodel.getUsername())
    }
    
    // when doLogin is invoked with valid username and password,
    //      1. username should stored in utilities
    //      2. token returned from services should be persisted in service manager
    //      3. router's login should be triggered
    // This function tests if these 3 events are happening or not...
    func test_doLogin_success() {
        var viewmodel = LoginViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = true
        let test_token = "test_token"
        mockServiceManager.mock_session = Session.init(status: .success, token: test_token, failureDescription: nil)
        viewmodel.serviceManager = mockServiceManager
        
        viewmodel.doLogin(username: "test_username", password: "test_password")
        
        let userdefaults = UserDefaults.standard
        XCTAssertEqual(userdefaults.value(forKey: "stored_username") as! String, "test_username")
        XCTAssertEqual(DataManager.apiToken, test_token)
        XCTAssertTrue(mockRouter.is_login_called)
    }
    
    // when doLogin is invoked with in-valid username and password,
    //      1. ServiceManager's token should become nil
    //      2. alert should be fired from delegate
    // This function tests if these 3 events are happening or not...
    func test_doLogin_failure() {
        DataManager.apiToken = nil
        var viewmodel = LoginViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        let mockRouter = RouterMock.init()
        viewmodel.router = mockRouter
        
        var mockServiceManager = ServiceManagerMock.init()
        mockServiceManager.isServiceCallSuccess = false

        mockServiceManager.mock_error_session = Session.init(status: .failed, token: nil, failureDescription: "Test failure description")
        mockServiceManager.mock_error = NSError.init(domain: "com.testError", code: 1001, userInfo: nil)
        viewmodel.serviceManager = mockServiceManager
        
        viewmodel.doLogin(username: "test_username", password: "test_password")
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
        
        mockServiceManager.mock_error_session = nil
        viewmodel.serviceManager = mockServiceManager
        viewmodel.doLogin(username: "test_username", password: "test_password")
        XCTAssertNil(DataManager.apiToken)
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
    }
    
    // when doLogin is invoked with empty username or password, validation error alert should be fired from the delegate
    // This function tests if such alert is fired or not...
    func test_doLogin_emptyCredentials() {
        var viewmodel = LoginViewModel.init()
        
        let mockDelegate = ViewModelProtocolMock.init()
        viewmodel.delegate = mockDelegate
        
        viewmodel.doLogin(username: "", password: "")
        XCTAssertTrue(mockDelegate.is_showStaticAlert_Called)
    }
}
