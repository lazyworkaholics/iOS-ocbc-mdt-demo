//
//  ViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 27/10/21.
//

import UIKit

class LoginViewController: GenericViewController {
    //MARK:- variables and initializers
    var viewModel: LoginViewModel!
    
    class func initWithViewModel(_ viewModel: LoginViewModel) -> LoginViewController {
        let viewController = LoginViewController.init()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.setupUILayout()
        return viewController
    }
}

extension LoginViewController: ButtonCellProtocol {
    func buttonClick(_ indexPath: IndexPath, and reuseIdentifier: String) {
        if reuseIdentifier == TextFieldCell.reuseidentifier() {
            viewModel.notUsername()
        } else if reuseIdentifier == ButtonCell.reuseidentifier() {
            dismissKeyboard(UITapGestureRecognizer.init())
            let usernameCell = collectionView.cellForItem(at: IndexPath.init(item: 0, section: 1)) as! TextFieldCell
            let passwordCell = collectionView.cellForItem(at: IndexPath.init(item: 0, section: 2)) as! TextFieldCell
            viewModel.doLogin(username: usernameCell.textField.text ?? "", password: passwordCell.textField.text ?? "")
        }
    }
}
