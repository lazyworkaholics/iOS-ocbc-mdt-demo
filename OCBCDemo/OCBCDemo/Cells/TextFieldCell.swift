//
//  TextFieldButtonCell.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

protocol ButtonCellProtocol {
    func buttonClick(_ indexPath: IndexPath, and reuseIdentifier: String)
}

class TextFieldCell: UICollectionViewCell {
    
    static let height:CGFloat = 64.0
    var delegate: ButtonCellProtocol?
    var indexPath: IndexPath?
    
    var leftIconView: UIImageView?
    var leftLabel: PrimaryLabel?
    var textField: PrimaryTextField!
    var button: TertiaryButton?
    
    func setupLayout(_ isLeftIcon:Bool = false, isLeftLabel:Bool = false, isRightButton:Bool = false) {
        contentView.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.QUATERNARY)
        let stackView = UIStackView.init()
        stackView.axis = .horizontal
        stackView.spacing = 8.0
        stackView.wrap(into: contentView, contentMode: .fill, with: .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0))
        if isLeftIcon {
            leftLabel = nil
            leftIconView = UIImageView.init()
            leftIconView?.contentMode = .scaleAspectFit
            leftIconView?.setWidth(width: 40)
            stackView.addArrangedSubview(leftIconView!)
        } else if isLeftLabel {
            leftIconView = nil
            leftLabel = PrimaryLabel.init()
            leftLabel?.setWidth(width: 120)
            leftLabel?.font = .boldSystemFont(ofSize: 12)
            stackView.addArrangedSubview(leftLabel!)
        }
        textField = PrimaryTextField.init()
        stackView.addArrangedSubview(textField)
        if isRightButton {
            button = TertiaryButton.init(type: .custom)
            button?.setWidth(width: 80)
            stackView.addArrangedSubview(button!)
            button?.addTarget(self, action: #selector(onButtonClick), for: .touchUpInside)
        }
    }
    
    func loadData(_ leftIcon:UIImage? = nil, leftLabelText:String? = nil, text:String, placeholder: String, buttonTitle: String? = nil, indexPath:IndexPath) {
        
        leftIconView?.image = leftIcon
        leftLabel?.text = leftLabelText
        textField.text = text
        if text != "" {
            textField.isUserInteractionEnabled = false
        } else {
            textField.isUserInteractionEnabled = true
        }
        textField.placeholder = placeholder
        if buttonTitle != nil {
            button?.isHidden = false
            button?.setTitle(buttonTitle, for: .normal)
        } else {
            button?.isHidden = true
        }
        self.indexPath = indexPath
        textField.tag = indexPath.section
    }
    
    @objc func onButtonClick() {
        delegate?.buttonClick(indexPath ?? IndexPath.init(item: 0, section: 0), and: self.reuseIdentifier!)
    }
}
