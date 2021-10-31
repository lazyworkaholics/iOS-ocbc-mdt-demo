//
//  Label.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class KeyValueCell: UICollectionViewCell {
    
    static let height:CGFloat = 80
    var delegate: ButtonCellProtocol?
    var indexPath: IndexPath?
    
    var keyLabel: UILabel!
    var valueLabel: UILabel!
    var accessoryButton: TertiaryButton?
    
    func setupLayout(_ keyText:String, isButtonShown:Bool = false) {
        
        contentView.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.QUATERNARY)
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.wrap(into: contentView, contentMode: .fill, with: .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0))
        
        keyLabel = UILabel.init()
        keyLabel.font = .boldSystemFont(ofSize: 17)
        keyLabel.text = keyText
        keyLabel.textAlignment = .left
        stackView.addArrangedSubview(keyLabel)
        
        valueLabel = UILabel.init()
        valueLabel.setWidth(width: 130)
        valueLabel.font = .boldSystemFont(ofSize: 17)
        stackView.addArrangedSubview(valueLabel)
        if isButtonShown {
            accessoryButton = TertiaryButton.init(type: .custom)
            accessoryButton?.setWidth(width: 120.0)
            stackView.addArrangedSubview(accessoryButton!)
            accessoryButton?.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        }
    }
    
    func loadData(_ text:String?, buttonTitle: String? = nil, indexPath:IndexPath) {
        
        if text != nil {
            valueLabel.text = text
        }
        if buttonTitle == nil {
            accessoryButton?.isHidden = true
        } else {
            accessoryButton?.isHidden = false
            accessoryButton?.setTitle(buttonTitle, for: .normal)
        }
        self.indexPath = indexPath
    }
    
    @objc func onButtonClick() {
        
        delegate?.buttonClick(indexPath ?? IndexPath.init(item: 0, section: 0), and: self.reuseIdentifier!)
    }
}
