//
//  LoginViewControllerTests.swift
//  OCBCDemoTests
//
//  Created by Harsha on 30/10/21.
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
}
