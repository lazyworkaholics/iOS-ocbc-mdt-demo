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
    var collectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var activityindicator: UIActivityIndicatorView! = UIActivityIndicatorView.init(style: .medium)
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: LoginViewModel) -> LoginViewController {
//        let storyBoardRef = UIStoryboard.init(name: CONSTANTS.MAIN, bundle: nil)
//        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.LOGIN) as! LoginViewController
        let viewController = LoginViewController.init()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.setupUILayout()
        return viewController
    }
}

extension LoginViewController: LoginProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        presentAlert(with: title, message: message, onClick: onClick)
    }
    
    func loadingActivity(_ isShow:Bool) {
        DispatchQueue.main.async(execute: {() -> Void in
            if isShow {
                self.activityindicator.startAnimating()
            } else {
                self.activityindicator.stopAnimating()
            }
        })
    }
    
    func reload() {
        DispatchQueue.main.async(execute: {() -> Void in
            self.collectionView.reloadData()
        })
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
