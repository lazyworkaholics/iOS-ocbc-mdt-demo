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
    var collectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var activityindicator: UIActivityIndicatorView! = UIActivityIndicatorView.init(style: .medium)
    
    //MARK:- init and viewDidLoads
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

extension TransferViewController: TransferProtocol {
    func showAlert(_ title: String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        presentAlert(with: title, message: message, onClick: onClick)
    }
    
    func loadingActivity(_ isShow:Bool) {
        
    }
    
    func reload() {
        
    }
}
