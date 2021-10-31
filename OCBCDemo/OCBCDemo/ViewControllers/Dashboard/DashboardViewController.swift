//
//  DashboardViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class DashboardViewController: GenericViewController {
    
    //MARK:- variables and initializers
    var viewModel: DashboardViewModel!
    
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> DashboardViewController {
        
        let viewController = DashboardViewController()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.setupUILayout()
        return viewController
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupBarButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        viewModel.getDashboardData()
    }
}

extension DashboardViewController: ButtonCellProtocol {
    
    func buttonClick(_ indexPath: IndexPath, and reuseIdentifier: String) {
        
        if indexPath.section == 0 && reuseIdentifier == KeyValueCell.reuseidentifier()
        {
            viewModel.onTransferClick()
        }
        else if indexPath.section == 1 && reuseIdentifier == PayeeCollectionCell.reuseidentifier()
        {
            viewModel.onTransferClick(viewModel.getPayee(for: indexPath.item))
        }
    }
}
