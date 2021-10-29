//
//  ViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 27/10/21.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK:- iboutlets and variables
    var viewModel: LoginViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: LoginViewModel) -> LoginViewController {
        let storyBoardRef = UIStoryboard.init(name: LITERALS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.LOGIN) as! LoginViewController
        viewController.viewModel = viewModel
        viewController.viewModel.protocolVC = viewController
        return viewController
    }
}

extension LoginViewController: LoginProtocol {
    
}

