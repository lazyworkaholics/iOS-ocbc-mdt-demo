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
        
        for cell in collectionView.visibleCells {
            if cell.isKind(of: TextFieldCell.self) {
                let refTextField = (cell as! TextFieldCell).textField
                if refTextField?.text != "" {
                    switch refTextField?.tag {
                    case 0:
                        viewModel.setAccountNumber(refTextField!.text ?? "")
                    case 1:
                        viewModel.setAmount(Double(refTextField!.text ?? "")!)
                    default:
                        viewModel.setDescription(refTextField!.text ?? "")
                    }
                }
            }
        }
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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string != "" {
            if textField.tag == 1 {
                let splitArray = textField.text?.components(separatedBy: ".") ?? []
                if splitArray.count > 1 {
                    let decimalString = splitArray[1]
                    if decimalString.count >= 2 {
                        return false
                    }
                }
            }
        }
        return true
    }
}
