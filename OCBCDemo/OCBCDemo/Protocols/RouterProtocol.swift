//
//  RouterProtocol.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol RouterProtocol {
    
    func launch()
    func logout()
    func login()
    func goHome()
    func navigateToTransferView(with payee:Payee?)
}
