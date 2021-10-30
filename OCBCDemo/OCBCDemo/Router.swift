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
    var rootNavigationController:UINavigationController?
    
    var loginViewController: LoginViewController!
    var dashboardViewController: DashboardViewController!
    var transferViewController: TransferViewController!
    var detailViewController: DetailViewController!
    var settingsViewController: SettingsViewController!
    
    var loginViewModel: LoginViewModel?
    var dashboardViewModel: DashboardViewModel?
    var transferViewModel: TransferViewModel?
    var detailViewModel: DetailViewModel?
    var settingsViewModel: SettingsViewModel?
    
    var currentRouteState:AppRouteState?
    
    func launch() {
        ServiceManager.token = nil
        currentRouteState = nil
        logout()
    }
    
    func login() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            if ServiceManager.token != nil, self.currentRouteState == .loginView {
                self.dashboardViewModel = DashboardViewModel.init()
                self.dashboardViewController = DashboardViewController.initWithViewModel(self.dashboardViewModel!)
                self.rootNavigationController = UINavigationController(rootViewController: self.dashboardViewController)
    //            rootNavigationController?.navigationBar.barTintColor = UIColor.init(named: "STRINGS.COLORS.NAVIGATION")
                appdelegate.window?.rootViewController = self.rootNavigationController!
                appdelegate.window?.makeKeyAndVisible()
                self.currentRouteState = AppRouteState.dashboardView
            }
        })
    }
    
    func navigateToTransferView(with payee:Payee?) {
        
    }
    
    func navigateToDetailView(with transactionDetails:Transaction?, or transferAcknowledgment:Transfer?) {
        
    }
    
    func goHome() {
        
    }
    
    func presentSettings() {
        
    }
    
    func dismissSettings() {
        
    }
    
    func logout() {
        DispatchQueue.main.async(execute: {() -> Void in
            
            let appdelegate = UIApplication.shared.delegate as! AppDelegate
            if ServiceManager.token == nil, self.currentRouteState != .loginView {
                self.loginViewModel = LoginViewModel.init()
                self.loginViewController = LoginViewController.initWithViewModel(self.loginViewModel!)
                appdelegate.window?.tintColor = .lightGray
                appdelegate.window?.rootViewController = self.loginViewController!
                appdelegate.window?.makeKeyAndVisible()
                self.currentRouteState = AppRouteState.loginView
            }
        })
    }
}
