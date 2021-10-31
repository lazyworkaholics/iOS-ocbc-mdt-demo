//
//  RouterTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import XCTest
@testable import OCBCDemo

class RouterTests: XCTestCase {

    
    func test_login() {
        let router = Router()
        router.currentRouteState = .loginView
        DataManager.apiToken = "test"
        router.login()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(router.dashboardViewModel)
            XCTAssertNotNil(router.dashboardViewController)
            XCTAssertNotNil(router.loggedInNavigationController)
        }
    }
    
    func test_logout() {
        let router = Router()
        router.currentRouteState = .dashboardView
        router.logout()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNil(router.dashboardViewModel)
            XCTAssertNil(router.dashboardViewController)
            XCTAssertNil(router.loggedInNavigationController)
            
            XCTAssertNotNil(router.loginViewModel)
            XCTAssertNotNil(router.loginViewController)
            XCTAssertEqual(router.currentRouteState, AppRouteState.dashboardView)
        }
    }
    
    func test_lauch() {
        let router = Router()
        router.launch()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(router.loginViewModel)
            XCTAssertNotNil(router.loginViewController)
            XCTAssertEqual(router.currentRouteState, AppRouteState.dashboardView)
        }
    }
    
    func test_goHome() {
        let router = Router()
        router.goHome()
        XCTAssertEqual(router.currentRouteState, AppRouteState.dashboardView)
    }
    
    func test_transferViewNavigation() {
        let router = Router()
        router.currentRouteState = .dashboardView
        router.navigateToTransferView(with: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(router.transferViewModel)
            XCTAssertNotNil(router.transferViewController)
        }
    }

}
