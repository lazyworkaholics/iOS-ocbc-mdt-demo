//
//  LoginViewModel.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

struct LoginViewModel {
    //MARK:- variables and initializers
    var delegate: ViewModelProtocol?
    var serviceManager: ServiceManagerProtocol!
    var router:RouterProtocol!
    private var isNotUsernameEnabled = false
    
    init() {
        serviceManager = ServiceManager.init()
        router = Router.sharedInstance
    }
    
    // MARK: - LoginViewController - Action Handlers
    func doLogin(username: String, password: String) {
        if username != "", password != "" {
            delegate?.loadingActivity(true)
            
            serviceManager?.login(username, password: password, onSuccess: {
                session in
                delegate?.loadingActivity(true)
                Utilities().saveUsername(username: username)
                DataManager.apiToken = session.token
                router.login()
            }, onFailure: {
                session, error in
                delegate?.errorHandlerOnFailure(session: session, error: error)
            })
        } else {
            delegate?.showAlert(LITERAL.ERROR, message: LITERAL.DESCRIPTION.ERROR.LOGIN, actionTitles: [], actions: [])
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
}
