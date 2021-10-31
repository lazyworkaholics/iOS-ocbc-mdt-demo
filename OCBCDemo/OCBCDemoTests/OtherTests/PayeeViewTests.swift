//
//  PayeeViewTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 31/10/21.
//

import XCTest
@testable import OCBCDemo

class PayeeViewTests: XCTestCase {

    func test_payeeView_init() {
        
        let test_indexpath = IndexPath.init(item: 5, section: 6)
        let test_reuseIdentifier = "test_identifier"
        let payeeView = PayeeView.init(test_indexpath, and: test_reuseIdentifier)
        payeeView.onClick()
        XCTAssertEqual(payeeView.indexpath, test_indexpath)
        XCTAssertEqual(payeeView.reuseIdentifier, test_reuseIdentifier)
        
        let mock_image = UIImage.init(named: "username")
        payeeView.setImage(mock_image!)
        XCTAssertEqual(payeeView.imageView.image, mock_image)
        
        let accountName = "test_accountName"
        payeeView.setAccountName(accountName)
        XCTAssertEqual(payeeView.accountNameLabel.text, accountName)
        
        let accountN0 = "test_accountN0"
        payeeView.setAccountNo(accountN0)
        XCTAssertEqual(payeeView.accountNoLabel.text, accountN0)
    }

}
