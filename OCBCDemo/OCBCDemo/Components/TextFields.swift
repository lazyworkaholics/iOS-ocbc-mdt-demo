//
//  TextFields.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

class PrimaryTextField: UITextField {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        applyBorder()
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 8.0, height: frame.size.height))
        leftViewMode = .always
        autocapitalizationType = .none
        autocorrectionType = .no
        clearButtonMode = .whileEditing
    }
}
