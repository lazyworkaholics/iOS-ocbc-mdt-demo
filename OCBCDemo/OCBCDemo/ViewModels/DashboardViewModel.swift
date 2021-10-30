//
//  DashboardViewModel.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import Foundation

struct DashboardViewModel {
    //MARK:- variables and initializers
    var delegate: DashboardProtocol?
    var serviceManager: ServiceManagerProtocol!
    var router:RouterProtocol!
    
    init() {
        serviceManager = ServiceManager.init()
        router = Router.sharedInstance
    }
    
    // MARK: - DashboardViewController - action handlers
    func getDashboardData() {

        serviceManager.getDashboardData(DataManager.apiToken!, onCompletion: {
            balanceGetter, payeeGetter, transactionGetter, errorSession, error in
            if errorSession != nil || error != nil {
                delegate?.errorHandlerOnFailure(session: errorSession, error: error!, delegate: delegate!)
            }
            DataManager.balanceGetter = balanceGetter
            DataManager.payeeGetter = payeeGetter
            DataManager.transactionGetter = transactionGetter
            delegate?.reload()
        })
    }
    
    func logout() {
        DataManager.apiToken = nil
        router.logout()
    }
    
    func onTransferClick(_ payee: Payee? = nil)  {
        router.navigateToTransferView(with: payee)
    }
    
    // MARK: - DashboardViewController - data handlers
    func getBalance() -> String? {
        if let balance = DataManager.balanceGetter?.balance {
            return "SGD " + String(format: "%.2f", balance)
        }
        return nil
    }
    
    func getPayeeCount() -> Int? {
        return DataManager.payeeGetter?.payees?.count
    }
    
    func getAllPayees() -> [Payee] {
        return DataManager.payeeGetter?.payees ?? []
    }
    
    func getPayee(for index:Int) -> Payee? {
        return DataManager.payeeGetter?.payees?[index]
    }
    
    func getTransactionsCount() -> Int? {
        return DataManager.transactionGetter?.transactions?.count
    }
    
    func getTransaction(for index:Int) -> Transaction? {
        return DataManager.transactionGetter?.transactions?[index]
    }
}
