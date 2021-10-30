//
//  ImageCell.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    static let height:CGFloat = 280.0
    var imageView: UIImageView!
    
    func setupLayout() {
        imageView = UIImageView.init()
        imageView?.wrap(into: contentView, contentMode: .fill, with: .zero)
        imageView.contentMode = .scaleAspectFill
    }
    
    func loadData(_ image: UIImage) {
        imageView.image = image
    }
}
