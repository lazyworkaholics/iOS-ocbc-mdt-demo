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
        
        let rigthBarButton = UIBarButtonItem.init(title: "Logout", style: .done, target: self, action: #selector(logout))
        rigthBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = rigthBarButton
        let leftBarButton = UIBarButtonItem.init(image: UIImage.init(named: ICON.BACK), style: .done, target: self, action: #selector(back))
        leftBarButton.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButton
    }
    
    @objc fileprivate func logout() {
        
        viewModel.logout()
    }
    
    @objc fileprivate func back() {
        
        viewModel.back()
    }
}

extension TransferViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ButtonCell.reuseidentifier(), for: indexPath) as! ButtonCell
            if cell.button == nil {
                cell.setupLayout()
                cell.delegate = self
            }
            cell.loadData(LITERAL.SEND, indexPath: indexPath)
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextFieldCell.reuseidentifier(), for: indexPath) as! TextFieldCell
            if cell.textField == nil {
                cell.setupLayout( isLeftLabel: true)
            }
            switch indexPath.section {
            case 0:
                cell.loadData(leftLabelText: viewModel.getAccountName(), text: viewModel.getAccountNumber(), placeholder: "", indexPath: indexPath)
                cell.textField.keyboardType = .numberPad
            case 1:
                cell.loadData(leftLabelText: LITERAL.AMOUNT, text: "", placeholder: "", indexPath: indexPath)
                cell.textField.keyboardType = .decimalPad
            default:
                cell.loadData(leftLabelText: LITERAL.DESC, text: "", placeholder: "", indexPath: indexPath)
            }
            cell.textField.delegate = self
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
