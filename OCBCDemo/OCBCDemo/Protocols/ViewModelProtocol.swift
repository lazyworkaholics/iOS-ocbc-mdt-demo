//
//  ViewModelProtocols.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol ViewModelProtocol {
    
    func showAlert(_ title:String, message: String, actionTitles:[String], actions: [((UIAlertAction) -> Void)?])
    func loadingActivity(_ isShow:Bool)
    func reload()
}

extension ViewModelProtocol {
    
    func errorHandlerOnFailure(session:Session?, error:NSError) {
        
        var message = ""
        if session?.failureDescription != nil {
            message = (session?.failureDescription)!
        } else {
            message = error.localizedDescription
        }
        showAlert(LITERAL.ERROR, message: message, actionTitles: [], actions: [])
        loadingActivity(false)
    }
}
