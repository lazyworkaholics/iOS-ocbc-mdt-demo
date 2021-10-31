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
        
        dateString = Utilities().getCurrentDateString()
        if transferAccountNumber == nil || transferAccountNumber == "" || transferAmount == nil || transferAmount == 0 {
            delegate?.showAlert(LITERAL.ERROR, message: LITERAL.DESCRIPTION.ERROR.EMPTY_ACC, actionTitles: [], actions: [])
        } else if transferAccountNumber!.count < 8 {
            delegate?.showAlert(LITERAL.DESCRIPTION.TITLE.INVALID_ACC, message: LITERAL.DESCRIPTION.ERROR.INVALID_ACC, actionTitles: [], actions: [])
        }
        else if description == nil || description == "" {
            delegate?.showAlert(LITERAL.ERROR, message: LITERAL.DESCRIPTION.ERROR.EMPTY_DESC, actionTitles: [], actions: [])
        }
        else {
            let transferObj = Transfer.init(with: transferAmount!, recipientAccountNo: transferAccountNumber!, dateString: dateString!, description: description!)
            presentConfirmAlert(transferObj)
        }
    }
    
    private func presentConfirmAlert(_ transfer: Transfer) {
        
        let titleString = "Transfer SGD " + String(transferAmount!) + " to " + transferAccountNumber! + "?"
        delegate?.showAlert(titleString, message: LITERAL.OK_MESSAGE, actionTitles: [LITERAL.CANCEL, LITERAL.OK], actions: [{alertAction in}, {
            alertAction in
            makeTransfer(transfer)
        }])
    }
    
    func makeTransfer(_ transfer: Transfer) {
        
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
    }
    
    //MARK:- routing functions
    func logout() {
        
        DataManager.apiToken = nil
        router.logout()
    }
    
    func back() {
        
        router.goHome()
    }
    
    // MARK:- setter functions
    mutating func setAccountNumber(_ accoutNumber: String) {
        
        transferAccountNumber = accoutNumber
    }
    mutating func setAmount(_ amount: Double) {
        
        transferAmount = amount
    }
    mutating func setDescription(_ desc: String) {
        
        description = desc
    }
        
    // MARK: - TransferViewController - data handlers
    mutating func getAccountNumber() -> String {
        
        if transferAccountNumber == nil {
            transferAccountNumber = payee?.accountNo
        }
        return transferAccountNumber ?? ""
    }
    
    func getAccountName() -> String {
        
        return payee?.accountName ?? LITERAL.ACCOUNT_NO
    }
}
