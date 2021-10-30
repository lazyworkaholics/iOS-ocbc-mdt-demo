//
//  Router.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

enum AppRouteState:String {
    
    case loginView
    case dashboardView
    case transferView
    case detailView
    case settingsView
}

class Router: RouterProtocol {
    
    static var sharedInstance:Router = Router()
    var loggedInNavigationController:UINavigationController?
    
    var loginViewController: LoginViewController!
    var dashboardViewController: DashboardViewController!
    var transferViewController: TransferViewController!
    var detailViewController: DetailViewController!
    
    var loginViewModel: LoginViewModel?
    var dashboardViewModel: DashboardViewModel?
    var transferViewModel: TransferViewModel?
    var detailViewModel: DetailViewModel?
    
    var currentRouteState:AppRouteState?
    
    func launch() {
        DataManager.apiToken = nil
        currentRouteState = nil
        launchLoginView()
    }
    
    func login() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            if DataManager.apiToken != nil, self.currentRouteState == .loginView {
                self.dashboardViewModel = DashboardViewModel.init()
                self.dashboardViewController = DashboardViewController.initWithViewModel(self.dashboardViewModel!)
                self.loggedInNavigationController = UINavigationController(rootViewController: self.dashboardViewController)
                self.loggedInNavigationController?.navigationBar.barTintColor = UIColor.init(named: CUSTOM_COLOR.TINT.SECONDARY)
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.window?.rootViewController = self.loggedInNavigationController!
                appdelegate.window?.makeKeyAndVisible()
                
                self.currentRouteState = AppRouteState.dashboardView
                self.loginViewController = nil
                self.loginViewModel = nil
            }
        })
    }
    
    func navigateToTransferView(with payee:Payee?) {
        if DataManager.apiToken != nil, self.currentRouteState == .dashboardView {
            self.transferViewModel = TransferViewModel.init(payee)
            self.transferViewController = TransferViewController.initWithViewModel(self.transferViewModel!)
            self.loggedInNavigationController?.pushViewController(self.transferViewController, animated: true)
            self.currentRouteState = AppRouteState.transferView
        }
    }
    
    func navigateToDetailView(with transactionDetails:Transaction?, or transferAcknowledgment:Transfer?) {
        
    }
    
    func goHome() {
        self.loggedInNavigationController?.popToRootViewController(animated: true)
        self.currentRouteState = AppRouteState.dashboardView
    }
    
    func logout() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            if DataManager.apiToken == nil, self.currentRouteState != .loginView {
                self.launchLoginView()
                self.loggedInNavigationController = nil
                self.dashboardViewModel = nil
                self.dashboardViewController = nil
            }
        })
    }
    
    fileprivate func launchLoginView() {
        self.loginViewModel = LoginViewModel.init()
        self.loginViewController = LoginViewController.initWithViewModel(self.loginViewModel!)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.window?.tintColor = .lightGray
        appdelegate.window?.rootViewController = self.loginViewController!
        appdelegate.window?.makeKeyAndVisible()
        
        self.currentRouteState = AppRouteState.loginView
    }
}
