//
//  PrimaryButton.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class PrimaryButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(UIColor.init(named: "background_tertiary")!.cgColor)
        context!.fill(CGRect(x: 0, y: 0, width: 500, height: 500))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        setBackgroundImage(colorImage, for: .normal)
        titleLabel?.textColor = UIColor.init(named: "font_primary")
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
    }
}

class TertiaryButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        titleLabel?.textColor = UIColor.init(named: "font_tertiary")
    }
}

class SecondaryButton: TertiaryButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        applyBorder(with: UIColor.init(named: "border_tertiary")?.cgColor)
    }
}
