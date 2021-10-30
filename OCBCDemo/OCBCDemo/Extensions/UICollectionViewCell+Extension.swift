//
//  UICollectionViewExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

extension UICollectionViewCell {
    
    class func reuseidentifier() -> String {
        return String(describing: self)
    }
}
