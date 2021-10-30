//
//  TransferViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class TransferViewController: UIViewController {
    //MARK:- iboutlets and variables
    var viewModel: TransferViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: TransferViewModel) -> TransferViewController {
        let storyBoardRef = UIStoryboard.init(name: LITERALS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.TRANSFER) as! TransferViewController
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        return viewController
    }
}

extension TransferViewController: TransferProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        presentAlert(with: title, message: message, onClick: onClick)
    }
    
    func loadingActivity(_ isShow:Bool) {
        
    }
    
    func reload() {
        
    }
}
