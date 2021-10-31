//
//  RouterMock.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import Foundation
@testable import OCBCDemo

class RouterMock: RouterProtocol {

    var is_appLaunch_called = false
    var is_login_called = false
    var is_logout_called = false
    var is_gohome_called = false
    var is_presentSettings_called = false
    var is_dismissSettings_called = false
    
    var is_navigateToTransferView_called = false
    
    var payee_mock:Payee?
    var transaction_mock:Transaction?
    var transferAcknowledgment_mock:Transfer?
    
    func launch() {
        is_appLaunch_called = true
    }
    
    func login() {
        is_login_called = true
    }
    
    func navigateToTransferView(with payee:Payee?) {
        is_navigateToTransferView_called = true
        payee_mock = payee
    }
    
    func goHome() {
        is_gohome_called = true
    }
    
    func presentSettings() {
        is_presentSettings_called = true
    }
    
    func dismissSettings() {
        is_dismissSettings_called = true
    }
    
    func logout() {
        is_logout_called = true
    }
}
