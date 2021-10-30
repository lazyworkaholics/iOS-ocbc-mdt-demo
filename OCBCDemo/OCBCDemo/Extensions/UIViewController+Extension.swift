//
//  UIViewControllerExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

extension UIViewController {
    
    func presentAlert(with title:String, message: String, onClick: ((UIAlertAction) -> Void)?) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: LITERAL.OK, style: .default, handler: onClick))
            self.present(alert, animated: true, completion: nil)
        })
    }
}
