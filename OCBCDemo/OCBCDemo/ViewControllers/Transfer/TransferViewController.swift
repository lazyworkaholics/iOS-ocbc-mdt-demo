//
//  TransferViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class TransferViewController: GenericViewController {
    //MARK:- variables and initializers
    var viewModel: TransferViewModel!
    
    class func initWithViewModel(_ viewModel: TransferViewModel) -> TransferViewController {
        let viewController = TransferViewController()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.setupUILayout()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
    }
}

extension TransferViewController: ButtonCellProtocol {
    func buttonClick(_ indexPath: IndexPath, and reuseIdentifier: String) {
        viewModel.onTransferClick()
    }
}
