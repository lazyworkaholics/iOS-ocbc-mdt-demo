//
//  UIViewExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

extension UIView {
    
    func fromNib<T: UIView>(nibName: String, isInherited: Bool = false) -> T? {
        let bundle = Bundle(for: type(of: self))
        guard let contentView = bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T else {
            return nil
        }
        contentView.backgroundColor = .clear
        if isInherited {
            self.insertSubview(contentView, at: 0)
        } else {
            self.addSubview(contentView)
        }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.fixConstraintsInView(self)
        return contentView
    }
    
    func fixConstraintsInView(_ container: UIView!) {
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func fillToSuperView(margin: UIEdgeInsets = UIEdgeInsets.zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let viewSuperView = self.superview {
            self.topAnchor.constraint(equalTo: viewSuperView.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: viewSuperView.bottomAnchor, constant: margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: viewSuperView.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: viewSuperView.trailingAnchor, constant: margin.right).isActive = true
        }
    }
    
    public var heightConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .height && $0.relation == .equal
        })
    }
    public var widthConstraint: NSLayoutConstraint? {
        return constraints.first(where: {
            $0.firstAttribute == .width && $0.relation == .equal
        })
    }
    
    public var leadingConstraint: NSLayoutXAxisAnchor? {
        return self.leadingAnchor
    }
    public var trailingConstraint: NSLayoutXAxisAnchor? {
        return self.trailingAnchor
    }
    public var topConstraint: NSLayoutYAxisAnchor? {
        return self.topAnchor
    }
    public var bottomConstraint: NSLayoutYAxisAnchor? {
        return self.bottomAnchor
    }
}

extension UIView {
    
    public func roundedCorner(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    public func applyBorder(with color:CGColor? = UIColor.init(named: "border_primary")?.cgColor) {
        layer.borderWidth = 1
        layer.borderColor = color
        layer.cornerRadius = 4.0
        clipsToBounds = true
    }
    
    public func applyScaleAnimation(scalex: CGFloat, scaley: CGFloat, zoomInDuration: CGFloat, zoomOutDuration: CGFloat) {
        UIView.animate(withDuration: TimeInterval(zoomInDuration), animations: {() ->  Void in
            self.transform = CGAffineTransform(scaleX: scalex, y: scaley)
        }, completion: {(_ finished: Bool) -> Void in
            UIView.animate(withDuration: TimeInterval(zoomInDuration), animations: {() -> Void in
                self.transform = CGAffineTransform(scaleX: 1, y: 1)
            })
        })
    }
    
    public func resourceBundle() -> Bundle {
        let frameworkBundle = Bundle(for: type(of: self))
        let budleURL = frameworkBundle.resourceURL?.appendingPathComponent(".bundle")
        return Bundle(url: budleURL!) ?? frameworkBundle
    }
}

extension UIView {
    
    func getConvertedFrame(fromSubview subview: UIView) -> CGRect? {
        guard subview.isDescendant(of: self) else {
            return nil
        }
        var frame = subview.frame
        if subview.superview == nil {
            return frame
        }
        var superview = subview.superview
        while superview != self {
            frame = superview!.convert(frame, to: superview!.superview)
            if superview?.superview == nil {
                break
            } else {
                superview = superview?.superview
            }
        }
        return superview!.convert(frame, to: self)
    }
    
    func startShimmering() {
        let light = UIColor.white.cgColor
        let darkColor = UIColor(red: 0.56, green: 0.71, blue: 0.93, alpha: 1.0).cgColor
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3*self.bounds.size.width, height: self.bounds.size.height)
        gradient.colors = [light, darkColor, light]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
        gradient.locations = [0.35, 0.5, 0.65]
        self.layer.mask = gradient
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = 0.9
        animation.repeatCount = HUGE
        gradient.add(animation, forKey: "shimmer")
    }
    
    func stopShimmering() {
        self.layer.mask = nil
    }
}

extension UIView {
    
    public enum CustomContentMode {
        case fill
        case top
        case topWithHeight(CGFloat)
        case topWithProportion(CGFloat)
        case bottom
        case bottomWithHeight(CGFloat)
        case bottomWithProportion(CGFloat)
        case leading
        case leadingWithWidth(CGFloat)
        case leadingWithProportion(CGFloat)
        case trailing
        case trailingWithWidth(CGFloat)
        case trailingWithProportion(CGFloat)
        case center
        case centerWithSize(CGSize)
    }
    
    public func setWidth(width: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    public func setHeight(height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func setSize(width: CGFloat, height: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func wrap(into viewController: UIViewController, with margin: UIEdgeInsets = .zero) {
        viewController.view.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: viewController.view.topAnchor, constant: margin.top).isActive = true
        self.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor, constant: margin.bottom).isActive = true
        self.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor, constant: margin.left).isActive = true
        self.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor, constant: margin.right).isActive = true
    }
    
    public func wrap(into container: UIView, contentMode: CustomContentMode = .fill, with margin: UIEdgeInsets = .zero) {
        container.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        switch contentMode {
        case .fill:
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .top:
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .topWithHeight(let height):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .topWithProportion(let proportion):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: proportion).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .bottom:
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .bottomWithHeight(let height):
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .bottomWithProportion(let proportion):
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: proportion).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .leading:
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
        case .leadingWithWidth(let width):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .leadingWithProportion(let proportion):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: margin.left).isActive = true
            self.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: proportion).isActive = true
        case .trailing:
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
        case .trailingWithWidth(let width):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        case .trailingWithProportion(let proportion):
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: margin.top).isActive = true
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -margin.bottom).isActive = true
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -margin.right).isActive = true
            self.widthAnchor.constraint(equalTo: container.heightAnchor, multiplier: proportion).isActive = true
        case .center:
            self.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        case .centerWithSize(let size):
            self.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
            self.widthAnchor.constraint(equalToConstant: size.width).isActive = true
            self.heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}
