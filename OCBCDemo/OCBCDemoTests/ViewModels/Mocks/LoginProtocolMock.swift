//
//  LoginProtocolMock.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit
@testable import OCBCDemo

class LoginProtocolMock: LoginProtocol {
    
    var is_showLoadingIndicator_Called = false
    var is_showStaticAlert_Called = false
    var is_reloadData_called = false
    
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        is_showStaticAlert_Called = true
    }
    
    func loadingActivity(_ isShow: Bool) {
        is_showLoadingIndicator_Called = true
    }
    
    func reload() {
        is_reloadData_called = true
    }
}
