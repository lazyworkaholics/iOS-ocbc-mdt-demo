//
//  LoginViewControllerTests.swift
//  OCBCDemoTests
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import XCTest
@testable import OCBCDemo

class ViewControllerTests: XCTestCase {

    func test_login_initWithViewModel() {
        let viewmodel = LoginViewModel.init()
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.delegate)
    }
    
    // when a user click on "Not you? button, subsequent delegate's reload action should be invoked in the binding viewmodel
    // this function tests if this event is happening or not...
    func test_login_buttonClick_protocol_notYou() {
        var viewmodel = LoginViewModel.init()
        let mock_delegate = ViewModelProtocolMock.init()
        let mock_serviceManager = ServiceManagerMock.init()
        let mock_router = RouterMock.init()
        
        viewmodel.delegate = mock_delegate
        viewmodel.serviceManager = mock_serviceManager
        viewmodel.router = mock_router
        
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        viewController.buttonClick(IndexPath.init(item: 0, section: 0), and: TextFieldCell.reuseidentifier())
//        XCTAssertTrue(mock_delegate.is_reloadData_called)
//    }
//
//    // when a user click on Login button, subsequent delegate's showAlert or showActivity indicator to be called
//    // this function tests if this event is happening or not...
//    func test_buttonClick_protocol_login() {
//        var viewmodel = LoginViewModel.init()
//        let mock_delegate = ViewModelProtocolMock.init()
//        let mock_serviceManager = ServiceManagerMock.init()
//        let mock_router = RouterMock.init()
//
//        viewmodel.delegate = mock_delegate
//        viewmodel.serviceManager = mock_serviceManager
//        viewmodel.router = mock_router
//
//        let viewController = LoginViewController.initWithViewModel(viewmodel)
//        viewController.buttonClick(IndexPath.init(item: 0, section: 0), and: ButtonCell.reuseidentifier())
//        XCTAssertTrue(mock_delegate.is_showStaticAlert_Called)
//    }
    }
    
    func test_login_textFieldShouldReturn() {
        var viewmodel = LoginViewModel.init()
        let mock_delegate = ViewModelProtocolMock.init()
        let mock_serviceManager = ServiceManagerMock.init()
        let mock_router = RouterMock.init()
        
        viewmodel.delegate = mock_delegate
        viewmodel.serviceManager = mock_serviceManager
        viewmodel.router = mock_router
        
        let viewController = LoginViewController.initWithViewModel(viewmodel)
        
        let textField = UITextField()
        textField.tag = 1
        viewController.textFieldDidEndEditing(textField)
        XCTAssertTrue(viewController.textFieldShouldReturn(textField))
    }
    
    func test_dashboard_initWithViewModel() {
        DataManager.apiToken = "Tesst"
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        viewController.viewDidLoad()
        viewController.viewWillAppear(true)
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.delegate)
    }
    
    func test_datshboard_datasource() {
        let viewmodel = DashboardViewModel.init()
        let viewController = DashboardViewController.initWithViewModel(viewmodel)
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 3)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 1),1)
        
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 0)))
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 1)))
        
        let size1 = viewController.collectionView(viewController.collectionView, layout: UICollectionViewFlowLayout.init(), sizeForItemAt: IndexPath.init(item: 0, section: 0))
        XCTAssertEqual(size1.height, KeyValueCell.height)
        let size2 = viewController.collectionView(viewController.collectionView, layout: UICollectionViewFlowLayout.init(), sizeForItemAt: IndexPath.init(item: 0, section: 1))
        XCTAssertEqual(size2.height, PayeeCollectionCell.height)
        let size3 = viewController.collectionView(viewController.collectionView, layout: UICollectionViewFlowLayout.init(), sizeForItemAt: IndexPath.init(item: 0, section: 2))
        XCTAssertEqual(size3.height, TransactionCell.height)
    }
    
    func test_transfer_initWithViewModel() {
        DataManager.apiToken = "Tesst"
        let viewmodel = TransferViewModel.init()
        let viewController = TransferViewController.initWithViewModel(viewmodel)
        viewController.viewDidLoad()
        XCTAssertNotNil(viewController.viewModel)
        XCTAssertNotNil(viewController.viewModel.delegate)
    }
    
    func test_transfer_datasource() {
        DataManager.apiToken = "Tesst"
        let viewmodel = TransferViewModel.init()
        let viewController = TransferViewController.initWithViewModel(viewmodel)
        XCTAssertEqual(viewController.numberOfSections(in: viewController.collectionView), 4)
        XCTAssertEqual(viewController.collectionView(viewController.collectionView, numberOfItemsInSection: 1),1)
        
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 0)))
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 1)))
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 2)))
        XCTAssertNotNil(viewController.collectionView(viewController.collectionView, cellForItemAt: IndexPath.init(item: 0, section: 3)))
        
        let size3 = viewController.collectionView(viewController.collectionView, layout: UICollectionViewFlowLayout.init(), sizeForItemAt: IndexPath.init(item: 0, section: 2))
        XCTAssertEqual(size3.height, TextFieldCell.height)
    }
    
    func test_transaction_cell() {
        let transactionCell = TransactionCell.init()
        transactionCell.setupLayout()
        let indexPath1 = IndexPath.init(item: 9, section: 4)
        transactionCell.loadData("testData", nameText: "testName", descText: "test_des", amountText: "test_amount", indexPath: indexPath1)
        XCTAssertEqual(indexPath1, transactionCell.indexPath)
        XCTAssertEqual(transactionCell.nameLabel.text, "testName")
    }
}
