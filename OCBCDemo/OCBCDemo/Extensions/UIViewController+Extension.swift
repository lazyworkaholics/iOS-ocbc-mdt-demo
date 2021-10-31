//
//  UIViewControllerExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

extension UIViewController {
        
    func presentAlert(with title:String, message: String, actionTitles:[String], actions: [((UIAlertAction) -> Void)?]) {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
            if (actionTitles.count != actions.count) || actionTitles.count == 0 {
                alert.addAction(UIAlertAction.init(title: LITERAL.OK, style: .default, handler: nil))
            } else {
                for index in 0...actionTitles.count-1 {
                    alert.addAction(UIAlertAction.init(title: actionTitles[index], style: .default, handler: actions[index]))
                }
            }
            self.present(alert, animated: true, completion: nil)
        })
    }
}
