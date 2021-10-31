//
//  LoginViewControllerTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import XCTest
@testable import OCBCDemo

class LoginViewControllerTests: XCTestCase {

    func test_initWithViewModel() {
        let viewmodel = LoginViewModel.init()
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.delegate)
    }
    
    // when a user click on "Not you? button, subsequent delegate's reload action should be invoked in the binding viewmodel
    // this function tests if this event is happening or not...
    func test_buttonClick_protocol_notYou() {
        var viewmodel = LoginViewModel.init()
        let mock_delegate = ViewModelProtocolMock.init()
        let mock_serviceManager = ServiceManagerMock.init()
        let mock_router = RouterMock.init()
        
        viewmodel.delegate = mock_delegate
        viewmodel.serviceManager = mock_serviceManager
        viewmodel.router = mock_router
        
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        viewController.buttonClick(IndexPath.init(item: 0, section: 0), and: TextFieldCell.reuseidentifier())
//        XCTAssertTrue(mock_delegate.is_reloadData_called)
//    }
//
//    // when a user click on Login button, subsequent delegate's showAlert or showActivity indicator to be called
//    // this function tests if this event is happening or not...
//    func test_buttonClick_protocol_login() {
//        var viewmodel = LoginViewModel.init()
//        let mock_delegate = ViewModelProtocolMock.init()
//        let mock_serviceManager = ServiceManagerMock.init()
//        let mock_router = RouterMock.init()
//
//        viewmodel.delegate = mock_delegate
//        viewmodel.serviceManager = mock_serviceManager
//        viewmodel.router = mock_router
//
//        let viewController = LoginViewController.initWithViewModel(viewmodel)
//        viewController.buttonClick(IndexPath.init(item: 0, section: 0), and: ButtonCell.reuseidentifier())
//        XCTAssertTrue(mock_delegate.is_showStaticAlert_Called)
//    }
    }
    
    func test_textFieldShouldReturn() {
        var viewmodel = LoginViewModel.init()
        let mock_delegate = ViewModelProtocolMock.init()
        let mock_serviceManager = ServiceManagerMock.init()
        let mock_router = RouterMock.init()
        
        viewmodel.delegate = mock_delegate
        viewmodel.serviceManager = mock_serviceManager
        viewmodel.router = mock_router
        
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        
        let textField = UITextField()
        textField.tag = 1
        viewController.textFieldShouldReturn(textField)
        viewController.textFieldDidEndEditing(textField)
        XCTAssert(true)
    }
}
