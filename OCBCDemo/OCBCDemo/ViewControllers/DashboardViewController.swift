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
    var collectionView: UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    var activityindicator: UIActivityIndicatorView! = UIActivityIndicatorView.init(style: .medium)
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DashboardViewModel) -> DashboardViewController {
        let storyBoardRef = UIStoryboard.init(name: CONSTANTS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.DASHBOARD) as! DashboardViewController
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

extension DashboardViewController: DashboardProtocol {
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
