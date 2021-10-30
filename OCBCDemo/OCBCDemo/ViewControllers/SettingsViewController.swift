//
//  SettingsViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    //MARK:- iboutlets and variables
    var viewModel: SettingsViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: SettingsViewModel) -> SettingsViewController {
        let storyBoardRef = UIStoryboard.init(name: CONSTANTS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.SETTINGS) as! SettingsViewController
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        return viewController
    }
}

extension SettingsViewController: SettingsProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        presentAlert(with: title, message: message, onClick: onClick)
    }
    
    func loadingActivity(_ isShow:Bool) {
        
    }
    
    func reload() {
        
    }
}
