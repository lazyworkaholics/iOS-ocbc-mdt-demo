//
//  DashboardViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class DashboardViewController: UIViewController {
    //MARK:- iboutlets and variables
    var viewModel: DashboardViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> DashboardViewController {
        let storyBoardRef = UIStoryboard.init(name: LITERALS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.DASHBOARD) as! DashboardViewController
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        return viewController
    }
}

extension DashboardViewController: DashboardProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        presentAlert(with: title, message: message, onClick: onClick)
    }
    
    func loadingActivity(_ isShow:Bool) {
        
    }
    
    func reload() {
        
    }
}
