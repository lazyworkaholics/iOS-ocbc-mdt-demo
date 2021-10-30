//
//  ServiceManagerMock.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import Foundation
@testable import OCBCDemo

struct ServiceManagerMock: ServiceManagerProtocol {
    
    var isServiceCallSuccess: Bool?
    var mock_session: Session?
    var mock_balanceGetter: BalanceGetter?
    var mock_PayeeGetter: PayeeGetter?
    var mock_TransactionGetter: TransactionGetter?
    var mock_MakeTransfer: MakeTransfer?
    var mock_error: NSError?
    var mock_error_session: Session?
    
    func login(_ userName: String, password: String, onSuccess successBlock: @escaping (Session) -> Void, onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        if isServiceCallSuccess! {
            successBlock(mock_session!)
        } else {
            failureBlock(mock_error_session, mock_error!)
        }
    }
    
    func getBalance(_ token: String, onSuccess successBlock: @escaping (BalanceGetter) -> Void, onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        if isServiceCallSuccess! {
            successBlock(mock_balanceGetter!)
        } else {
            failureBlock(mock_error_session, mock_error!)
        }
    }
    
    func getPayees(_ token: String, onSuccess successBlock: @escaping (PayeeGetter) -> Void, onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        if isServiceCallSuccess! {
            successBlock(mock_PayeeGetter!)
        } else {
            failureBlock(mock_error_session, mock_error!)
        }
    }
    
    func getTransactions(_ token: String, onSuccess successBlock: @escaping (TransactionGetter) -> Void, onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        if isServiceCallSuccess! {
            successBlock(mock_TransactionGetter!)
        } else {
            failureBlock(mock_error_session, mock_error!)
        }
    }
    
    func makeTransfer(_ token: String, transfer: Transfer, onSuccess successBlock: @escaping (MakeTransfer) -> Void, onFailure failureBlock: @escaping (Session?, NSError) -> Void) {
        if isServiceCallSuccess! {
            successBlock(mock_MakeTransfer!)
        } else {
            failureBlock(mock_error_session, mock_error!)
        }
    }
}
