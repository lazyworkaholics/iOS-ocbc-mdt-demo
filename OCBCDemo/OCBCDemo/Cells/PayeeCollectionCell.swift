//
//  PayeeCollectionCell.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class PayeeCollectionCell: UICollectionViewCell {

    static let height:CGFloat = 200
    
    var stackView:UIStackView?
    
    func setupLayout() {
        let parentStackView = UIStackView.init()
        parentStackView.axis = .vertical
        parentStackView.wrap(into: contentView, contentMode: .fill, with: .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0))
        
        let headerLable = PrimaryLabel.init()
        headerLable.text = "Payees"
        headerLable.font = .boldSystemFont(ofSize: 20)
        parentStackView.addArrangedSubview(headerLable)
        
        let scrollView = UIScrollView.init()
        scrollView.backgroundColor = .clear
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        parentStackView.addArrangedSubview(scrollView)
        
        stackView = UIStackView.init()
        stackView?.axis = .horizontal
        stackView?.spacing = 8.0
        stackView?.wrap(into: scrollView)
        
        let footerLabel = PrimaryLabel.init()
        footerLabel.text = "Recent Transactions"
        footerLabel.font = .boldSystemFont(ofSize: 20)
        footerLabel.wrap(into: contentView, contentMode: .bottomWithHeight(21), with: UIEdgeInsets.init(top: 0, left: 16.0, bottom: 8.0, right: 16.0))
    }
    
    func loadData(_ payees:[Payee]) {
        for (index, payee) in payees.enumerated() {
            addPayee(payee, index: index)
        }
    }
    
    func addPayee(_ payee: Payee, index: Int) {
        let payeeView = PayeeView.init(frame: .zero)
        payeeView.layer.cornerRadius = 8.0
        stackView?.addArrangedSubview(payeeView)
        payeeView.setAccountName(payee.accountName)
        payeeView.setAccountNo(payee.accountNo)
    }
}
