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
