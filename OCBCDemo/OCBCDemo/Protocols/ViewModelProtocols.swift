//
//  ViewModelProtocols.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol ViewModelProtocol {
    
}

protocol LoginProtocol: ViewModelProtocol {
    
}

protocol DashboardProtocol: ViewModelProtocol {
    
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?)
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

protocol TransferProtocol: ViewModelProtocol {
    
}

protocol DetailProtocol: ViewModelProtocol {
    
}

protocol SettingsProtocol: ViewModelProtocol {
    
}
