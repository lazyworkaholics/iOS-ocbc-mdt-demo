//
//  ViewControllerProtocol.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import UIKit

class GenericViewController: UIViewController {
    
    var collectionView:UICollectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    var activityindicator:UIActivityIndicatorView = UIActivityIndicatorView.init(style: .medium)
}

extension GenericViewController: ViewModelProtocol {
    
    func showAlert(_ title: String, message: String, actionTitles: [String], actions: [((UIAlertAction) -> Void)?]) {
        
        presentAlert(with: title, message: message, actionTitles: actionTitles, actions: actions)
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
