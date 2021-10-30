//
//  TransferViewModel.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import Foundation

struct TransferViewModel {
    //MARK:- variables and initializers
    var delegate: TransferProtocol?
    var serviceManager: ServiceManagerProtocol!
    var router:RouterProtocol!
    var payee: Payee?
    
    init(_ payee: Payee? = nil) {
        serviceManager = ServiceManager.init()
        router = Router.sharedInstance
        self.payee = payee
    }
    
    // MARK: - TransferViewController - action handlers    
    func logout() {
        DataManager.apiToken = nil
        router.logout()
    }
    
    func back() {
        router.goHome()
    }
}
