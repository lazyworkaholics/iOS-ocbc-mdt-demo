//
//  RouterProtocol.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol RouterProtocol {
    
    func launch()
    
    func login()
    
    func navigateToTransferView(with payee:Payee?)
    
    func navigateToDetailView(with transactionDetails:Transaction?, or transferAcknowledgment:Transfer?)
    
    func goHome()
    
    func logout()
}
