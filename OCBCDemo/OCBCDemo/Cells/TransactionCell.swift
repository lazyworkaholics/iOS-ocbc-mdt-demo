//
//  TransactionsCell.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class TransactionCell: UICollectionViewCell {
    
    static let height:CGFloat = 90
    var indexPath: IndexPath!
    var dateLabel: UILabel!
    var nameLabel: UILabel!
    var descLabel: UILabel!
    var amountLable: UILabel!
    
    func setupLayout() {
        
        let parentStackView = UIStackView.init()
        contentView.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.QUATERNARY)
        parentStackView.axis = .horizontal
        parentStackView.wrap(into: contentView, contentMode: .fill, with: .init(top: 8.0, left: 16.0, bottom: 8.0, right: 16.0))
        
        let stackView = UIStackView.init()
        stackView.axis = .vertical
        stackView.spacing = 8.0
        parentStackView.addArrangedSubview(stackView)
        
        amountLable = UILabel.init()
        amountLable.setWidth(width: 180.0)
        amountLable.textAlignment = .right
        amountLable.font = .boldSystemFont(ofSize: 20)
        parentStackView.addArrangedSubview(amountLable)
        
        dateLabel = UILabel.init()
        dateLabel.font = .boldSystemFont(ofSize: 12)
        stackView.addArrangedSubview(dateLabel)
        nameLabel = UILabel.init()
        nameLabel.font = .boldSystemFont(ofSize: 12)
        stackView.addArrangedSubview(nameLabel)
        descLabel = UILabel.init()
        descLabel.font = .boldSystemFont(ofSize: 12)
        stackView.addArrangedSubview(descLabel)
    }
    
    func loadData(_ dateText: String, nameText: String, descText: String, amountText: String, indexPath: IndexPath) {
        
        dateLabel.text = dateText
        nameLabel.text = nameText
        descLabel.text = descText
        amountLable.text = amountText
        self.indexPath = indexPath
    }
}
