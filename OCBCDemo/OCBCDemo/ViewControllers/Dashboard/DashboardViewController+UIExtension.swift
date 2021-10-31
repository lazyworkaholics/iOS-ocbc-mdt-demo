//
//  DashboardViewController+UIExtension.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import UIKit

extension DashboardViewController {
    
    func setupUILayout() {
        self.view.backgroundColor = UIColor.init(named: CUSTOM_COLOR.BACKGROUND.SECONDARY)
        self.title = LITERAL.DASHBOARD_TITLE
        collectionView.backgroundColor = .clear
        collectionView.register(KeyValueCell.self, forCellWithReuseIdentifier: KeyValueCell.reuseidentifier())
        collectionView.register(PayeeCollectionCell.self, forCellWithReuseIdentifier: PayeeCollectionCell.reuseidentifier())
        collectionView.register(TransactionCell.self, forCellWithReuseIdentifier: TransactionCell.reuseidentifier())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.wrap(into: self, with: .zero)
        
        activityindicator.hidesWhenStopped = true
        activityindicator.color = UIColor.init(named: CUSTOM_COLOR.TINT.SECONDARY)
        activityindicator.wrap(into: self.view, contentMode: .centerWithSize(CGSize.init(width: 20, height: 20)))
    }
    
    func setupBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Logout", style: .done, target: self, action: #selector(logout))
    }
    
    @objc fileprivate func logout() {
        viewModel.logout()
    }
}

extension DashboardViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return viewModel.getTransactionsCount() ?? 0
        }
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: KeyValueCell.reuseidentifier(), for: indexPath) as! KeyValueCell
            if cell.keyLabel == nil {
                cell.setupLayout(LITERAL.BALANCE, isButtonShown: true)
                cell.delegate = self
            }
            cell.loadData(viewModel.getBalance(), buttonTitle: "Pay & Transfer", indexPath: indexPath)
            return cell
        case 1:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: PayeeCollectionCell.reuseidentifier(), for: indexPath) as! PayeeCollectionCell
            if cell.stackView == nil {
                cell.setupLayout()
                cell.delegate = self
            }
            cell.loadData(viewModel.getAllPayees(), indexpath: indexPath)
            return cell
        default:
            let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCell.reuseidentifier(), for: indexPath) as! TransactionCell
            if cell.dateLabel == nil {
                cell.setupLayout()
            }
            let transaction = viewModel.getTransaction(for: indexPath.item)
            cell.loadData((transaction?.dateString())!, nameText: (transaction?.nameAndNumber())!, descText: transaction?.description ?? "", amountText: (transaction?.amountString())!, indexPath: indexPath)
            return cell
        }
    }
}

extension DashboardViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let window = UIApplication.shared.windows[0]
        switch indexPath.section {
        case 0:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: KeyValueCell.height)
        case 1:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: PayeeCollectionCell.height)
        default:
            return CGSize.init(width: window.rootViewController!.view.bounds.width, height: TransactionCell.height)
        }
    }
}
