//
//  LoginViewModel.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

struct LoginViewModel {
    //MARK:- variables and initializers
    var delegate: LoginProtocol?
    var serviceManager: ServiceManagerProtocol!
    var router:RouterProtocol!
    var isNotUsernameEnabled = false
    
    init() {
        serviceManager = ServiceManager.init()
        router = Router.sharedInstance
    }
    
    // MARK: - LoginViewController - Action Handlers
    func doLogin(username: String, password: String) {
        if username != "", password != "" {
            serviceManager?.login(username, password: password, onSuccess: {
                session in
                Utilities().saveUsername(username: username)
                ServiceManager.token = session.token
                router.login()
            }, onFailure: {
                session, error in
                ServiceManager.token = nil
                var message = ""
                if session?.failureDescription != nil {
                    message = (session?.failureDescription)!
                } else {
                    message = error.localizedDescription
                }
                delegate?.showAlert(LITERAL.ERROR, message: message, onClick: nil)
            })
        } else {
            delegate?.showAlert(LITERAL.ERROR, message: LITERAL.DESCRIPTION.ERROR.LOGIN, onClick: nil)
        }
    }
    
    mutating func notUsername() {
        isNotUsernameEnabled = true
        delegate?.reload()
    }
    
    // MARK: - LoginViewController - Data Handlers
    func getUsername() -> String? {
        if isNotUsernameEnabled == false {
            return Utilities().getStoredUsername()
        }
        return nil
    }
    
    // MARK: - private functions
}
