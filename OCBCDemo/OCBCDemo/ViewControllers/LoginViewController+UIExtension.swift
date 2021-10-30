//
//  LoginViewController+UIExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

extension LoginViewController {
    
    func setupUILayout() {
        self.view.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.SECONDARY)
        collectionView.backgroundColor = .clear
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.reuseidentifier())
        collectionView.register(TextFieldCell.self, forCellWithReuseIdentifier: TextFieldCell.reuseidentifier())
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseidentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.wrap(into: self, with: .zero)
        
        activityindicator.hidesWhenStopped = true
        activityindicator.color = UIColor.init(named: CUSTOM_COLOR.TINT.SECONDARY)
        activityindicator.wrap(into: self.view, contentMode: .centerWithSize(CGSize.init(width: 20, height: 20)))
    }
}

extension LoginViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCell.reuseidentifier(), for: indexPath) as! ImageCell
            cell.setupLayout()
            cell.loadData(UIImage.init(named: ICON.LAUNCH)!)
            return cell
        case 1,2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.reuseidentifier(), for: indexPath) as! TextFieldCell
            if indexPath.section == 1 {
                let username:String? = viewModel.getUsername()
                if cell.textField == nil {
                    if username != nil {
                        cell.setupLayout(true, isRightButton: true)
                    } else {
                        cell.setupLayout(true)
                    }
                }
                if username != nil {
                    cell.loadData(UIImage.init(named: ICON.USERNAME), text: username ?? "", placeholder: LITERAL.USERNAME, buttonTitle: LITERAL.NOTYOU, indexPath: indexPath)
                    cell.delegate = self
                } else {
                    cell.loadData(UIImage.init(named: ICON.USERNAME), text: username ?? "", placeholder: LITERAL.USERNAME, indexPath: indexPath)
                }
            } else {
                if cell.textField == nil {
                    cell.setupLayout(true)
                }
                cell.loadData(UIImage.init(named: ICON.PASSWORD), text: "", placeholder: LITERAL.PASSWORD, indexPath: indexPath)
                cell.textField.isSecureTextEntry = true
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseidentifier(), for: indexPath) as! ButtonCell
            if cell.button == nil {
                cell.setupLayout()
                cell.delegate = self
            }
            cell.loadData(LITERAL.LOGIN, indexPath: indexPath)
            return cell
        }
    }
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let window = UIApplication.shared.windows[0]
        switch indexPath.section {
        case 0:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: ImageCell.height)
        case 1, 2:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: TextFieldCell.height)
        default:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: 100.0)
        }
    }
}
