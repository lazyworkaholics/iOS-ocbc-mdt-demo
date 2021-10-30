//
//  ViewModelProtocols.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol ViewModelProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?)
    func loadingActivity(_ isShow:Bool)
    func reload()
}

extension ViewModelProtocol {
    func errorHandlerOnFailure(session:Session?, error:NSError, delegate: ViewModelProtocol) {
        DataManager.apiToken = nil
        var message = ""
        if session?.failureDescription != nil {
            message = (session?.failureDescription)!
        } else {
            message = error.localizedDescription
        }
        delegate.showAlert(LITERAL.ERROR, message: message, onClick: nil)
        delegate.loadingActivity(false)
    }
}

protocol LoginProtocol: ViewModelProtocol {
    
}

protocol DashboardProtocol: ViewModelProtocol {
    
}

protocol TransferProtocol: ViewModelProtocol {
    
}

protocol DetailProtocol: ViewModelProtocol {
    
}

protocol SettingsProtocol: ViewModelProtocol {
    
}
