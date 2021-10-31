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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func showKeyboard(notification:NSNotification) {
        DispatchQueue.main.async {
        }
    }
    @objc func hideKeyboard(notification:NSNotification) {
        DispatchQueue.main.async {
        }
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

//MARK: - UITextFieldDelegate functions
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag < 3 {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: 0, section: tag+1)) as? TextFieldCell
            if cell != nil {
                cell?.textField.becomeFirstResponder()
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        if tag == 2 {
            buttonClick(IndexPath.init(row: 0, section: tag+1), and: ButtonCell.reuseidentifier())
        }
    }
}
