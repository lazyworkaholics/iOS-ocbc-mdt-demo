//
//  PayeeView.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class PayeeView: UIView {
    
    var indexpath: IndexPath!
    var reuseIdentifier: String!
    var delegate: ButtonCellProtocol?
    
    var imageView: UIImageView!
    var accountNameLabel: UILabel!
    var accountNoLabel: UILabel!
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
    }
    
    init(_ indexpath: IndexPath, and reuseIdentifier: String) {
        
        super.init(frame: .zero)
        self.indexpath = indexpath
        self.reuseIdentifier = reuseIdentifier
        
        self.backgroundColor = UIColor.init(named: CUSTOM_COLOR.THEME)
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        stackView.wrap(into: self)
        
        imageView = UIImageView.init()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage.init(named: ICON.USERNAME)
        stackView.addArrangedSubview(imageView)
        
        accountNameLabel = UILabel.init()
        accountNameLabel.textAlignment = .center
        accountNameLabel.setHeight(height: 21)
        stackView.addArrangedSubview(accountNameLabel)
        
        accountNoLabel = UILabel.init()
        accountNoLabel.textAlignment = .center
        accountNoLabel.setHeight(height: 21)
        stackView.addArrangedSubview(accountNoLabel)
        
        self.setWidth(width: 200)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onClick))
        addGestureRecognizer(tapGesture)
    }
    
    @objc func onClick() {
        
        delegate?.buttonClick(indexpath, and: reuseIdentifier)
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
