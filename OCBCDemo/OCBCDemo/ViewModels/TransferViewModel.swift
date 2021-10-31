//
//  TransferViewModel.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import Foundation

struct TransferViewModel {
    //MARK:- variables and initializers
    var delegate: ViewModelProtocol?
    var serviceManager: ServiceManagerProtocol!
    var router:RouterProtocol!
    
    private var payee: Payee?
    private var transferAccountNumber: String?
    private var transferAmount: Double?
    private var description: String?
    private var dateString: String?
    
    init(_ payee: Payee? = nil) {
        serviceManager = ServiceManager.init()
        router = Router.sharedInstance
        self.payee = payee
    }
    
    // MARK: - TransferViewController - action handlers
    mutating func onTransferClick() {
        transferAmount = 48.48
        description = "test"
        dateString = Utilities().getCurrentDateString()
        if transferAccountNumber == nil || transferAccountNumber == "" || transferAmount == nil {
            delegate?.showAlert(LITERAL.ERROR, message: "Account number and Amount cannot be empty", actionTitles: [], actions: [])
        }
        else if description == nil || description == "" {
            delegate?.showAlert(LITERAL.ERROR, message: "Give a valid description for the purpose of this transfer", actionTitles: [], actions: [])
        }
        else {
            let transferObj = Transfer.init(with: transferAmount!, recipientAccountNo: transferAccountNumber!, dateString: dateString!, description: description!)
            makeTransfer(transferObj)
        }
    }
    
    private func makeTransfer(_ transfer: Transfer) {
        
        let titleString = "Transfer SGD " + String(transferAmount!) + " to " + transferAccountNumber! + "?"
        
        delegate?.showAlert(titleString, message: "Click OK to confirm", actionTitles: [LITERAL.CANCEL, LITERAL.OK], actions: [{alertAction in}, {
            alertAction in
            
            delegate?.loadingActivity(true)
            serviceManager.makeTransfer(DataManager.apiToken!, transfer: transfer, onSuccess: {
                makeTransfer in
                
                delegate?.loadingActivity(false)
                let message = "Sent SGD " + String(makeTransfer.response!.amount) + " to " + makeTransfer.response!.recipientAccountNo
                delegate?.showAlert(LITERAL.SUCCESSFUL,
                                    message: message,
                                    actionTitles: [LITERAL.OK],
                                    actions: [{ alertAction in router.goHome()}])
            }, onFailure: {
                session, error in
                delegate?.errorHandlerOnFailure(session: session, error: error)
                delegate?.loadingActivity(false)
            })
        }])
    }
    
    //MARK:- routing functions
    func logout() {
        DataManager.apiToken = nil
        router.logout()
    }
    
    func back() {
        router.goHome()
    }
    
    // MARK: - TransferViewController - data handlers
    mutating func getAccountNumber() -> String {
        if transferAccountNumber == nil {
            transferAccountNumber = payee?.accountNo
        }
        return transferAccountNumber ?? ""
    }
}
