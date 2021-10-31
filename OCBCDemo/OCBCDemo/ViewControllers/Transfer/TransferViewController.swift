//
//  TransferViewController.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

class TransferViewController: GenericViewController {
    //MARK:- variables and initializers
    var viewModel: TransferViewModel!
    
    class func initWithViewModel(_ viewModel: TransferViewModel) -> TransferViewController {
        let viewController = TransferViewController()
        viewController.viewModel = viewModel
        viewController.viewModel.delegate = viewController
        viewController.setupUILayout()
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtons()
    }
}

extension TransferViewController: ButtonCellProtocol {
    func buttonClick(_ indexPath: IndexPath, and reuseIdentifier: String) {
        viewModel.onTransferClick()
    }
}

//MARK: - UITextFieldDelegate functions
extension TransferViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        if tag < 4 {
            let cell = collectionView.cellForItem(at: IndexPath.init(row: 0, section: tag+1)) as? TextFieldCell
            if cell != nil {
                cell?.textField.becomeFirstResponder()
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let tag = textField.tag
        if tag == 2 {
            buttonClick(IndexPath.init(row: 0, section: tag+1), and: ButtonCell.reuseidentifier())
        }
    }
}
