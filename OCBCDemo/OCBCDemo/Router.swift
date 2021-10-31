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
}

class Router: RouterProtocol {
    //MARK: - variables
    static var sharedInstance:Router = Router()
    var currentRouteState:AppRouteState?
    
    var loggedInNavigationController:UINavigationController?
    var loginViewController: LoginViewController!
    var dashboardViewController: DashboardViewController!
    var transferViewController: TransferViewController!
    
    var loginViewModel: LoginViewModel?
    var dashboardViewModel: DashboardViewModel?
    var transferViewModel: TransferViewModel?
    
    //MARK: - Protocol implementations
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
                
                self.loginViewController = nil
                self.loginViewModel = nil
                self.currentRouteState = AppRouteState.dashboardView
            }
        })
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
    
    func goHome() {
        
        self.loggedInNavigationController?.popToRootViewController(animated: true)
        self.currentRouteState = AppRouteState.dashboardView
    }
    
    func navigateToTransferView(with payee:Payee?) {
        
        if DataManager.apiToken != nil, self.currentRouteState == .dashboardView {
            self.transferViewModel = TransferViewModel.init(payee)
            self.transferViewController = TransferViewController.initWithViewModel(self.transferViewModel!)
            self.loggedInNavigationController?.pushViewController(self.transferViewController, animated: true)
            self.currentRouteState = AppRouteState.transferView
        }
    }
    
    //MARK: - private functions
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
