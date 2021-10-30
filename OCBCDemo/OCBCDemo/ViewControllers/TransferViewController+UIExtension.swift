//
//  TransferViewController+UIExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import UIKit

extension TransferViewController {
    func setupUILayout() {
        self.view.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.SECONDARY)
        self.title = LITERAL.TRANSFER_TITLE
        collectionView.backgroundColor = .clear
        collectionView.register(TextFieldCell.self, forCellWithReuseIdentifier: TextFieldCell.reuseidentifier())
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: ButtonCell.reuseidentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.wrap(into: self, with: .zero)
        
        activityindicator.hidesWhenStopped = true
        activityindicator.color = UIColor.init(named: CUSTOM_COLOR.TINT.SECONDARY)
        activityindicator.wrap(into: self.view, contentMode: .centerWithSize(CGSize.init(width: 20, height: 20)))
    
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        for cell in collectionView.visibleCells {
            if cell.isKind(of: TextFieldCell.self) {
                (cell as! TextFieldCell).textField.resignFirstResponder()
            }
        }
    }
    
    func setupBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(logout))
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: ICON.BACK), style: .done, target: self, action: #selector(back))
    }
    
    @objc fileprivate func logout() {
        viewModel.logout()
    }
    
    @objc fileprivate func back() {
        viewModel.back()
    }
}

extension TransferViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseidentifier(), for: indexPath) as! ButtonCell
            if cell.button == nil {
                cell.setupLayout()
            }
            cell.loadData("Send", indexPath: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.reuseidentifier(), for: indexPath) as! TextFieldCell
            if cell.textField == nil {
                cell.setupLayout()
            }
            switch indexPath.row {
            case 0:
                cell.loadData(text: "", placeholder: "Account Number", indexPath: indexPath)
            case 1:
                cell.loadData(text: "", placeholder: "Amount", indexPath: indexPath)
            default:
                cell.loadData(text: "", placeholder: "Description", indexPath: indexPath)
            }
            return cell
        }
    }
}

extension TransferViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let window = UIApplication.shared.windows[0]
        return CGSize.init(width: window.rootViewController!.view.bounds.width, height: TextFieldCell.height)
    }
}
