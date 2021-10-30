//
//  ButtonCell.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    
    static let height:CGFloat = 64.0
    var delegate: ButtonCellProtocol?
    var indexPath: IndexPath?
    var button: PrimaryButton?
    
    func setupLayout() {
        button = PrimaryButton.init(type: .custom)
        button?.wrap(into: contentView, contentMode: .bottomWithHeight(48.0), with: .init(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0))
        button?.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
    }
    
    func loadData(_ buttonTitle: String, indexPath:IndexPath) {
        button?.setTitle(buttonTitle, for: .normal)
        self.indexPath = indexPath
    }
    
    @objc func onButtonClick() {
        delegate?.buttonClick(indexPath ?? IndexPath.init(item: 0, section: 0), and: self.reuseIdentifier!)
    }
}
