//
//  PayeeView.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class PayeeView: UIView {
    
    var index: Int?
    
    var imageView: UIImageView!
    var accountNameLabel: PrimaryLabel!
    var accountNoLabel: PrimaryLabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(named: CUSTOM_COLOR.THEME)
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.wrap(into: self)
        
        imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: ICON.USERNAME)
        stackView.addArrangedSubview(imageView)
        
        accountNameLabel = PrimaryLabel.init()
        accountNameLabel.textAlignment = .center
        accountNameLabel.setHeight(height: 21)
        stackView.addArrangedSubview(accountNameLabel)
        
        accountNoLabel = PrimaryLabel.init()
        accountNoLabel.textAlignment = .center
        accountNoLabel.setHeight(height: 21)
        stackView.addArrangedSubview(accountNoLabel)
        
        self.setWidth(width: 200)
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
    
    func setAccountName(_ accountName: String) {
        accountNameLabel.text = accountName
    }
    
    func setAccountNo(_ accountNo: String) {
        accountNoLabel.text = accountNo
    }
}
