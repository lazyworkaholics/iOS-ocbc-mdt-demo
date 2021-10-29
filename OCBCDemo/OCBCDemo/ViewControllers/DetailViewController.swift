//
//  TransactionDetailViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class DetailViewController: UIViewController {
    //MARK:- iboutlets and variables
    var viewModel: DetailViewModel!
    
    //MARK:- init and viewDidLoads
    class func initWithViewModel(_ viewModel: DetailViewModel) -> DetailViewController {
        let storyBoardRef = UIStoryboard.init(name: LITERALS.MAIN, bundle: nil)
        let viewController = storyBoardRef.instantiateViewController(withIdentifier: VIEWCONTROLLERS.DETAIL) as! DetailViewController
        viewController.viewModel = viewModel
        viewController.viewModel.protocolVC = viewController
        return viewController
    }
}

extension DetailViewController: DetailProtocol {
    
}
