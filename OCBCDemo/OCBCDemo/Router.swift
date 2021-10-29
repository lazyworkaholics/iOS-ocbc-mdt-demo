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
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.apiToken = nil
        currentRouteState = nil
        logout()
    }
    
    func login() {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.apiToken == nil, currentRouteState == .loginView {
            dashboardViewModel = DashboardViewModel.init()
            dashboardViewController = DashboardViewController.initWithViewModel(self.dashboardViewModel!)
            rootNavigationController = UINavigationController(rootViewController: dashboardViewController)
            
//            rootNavigationController?.navigationBar.barTintColor = UIColor.init(named: "STRINGS.COLORS.NAVIGATION")
            appdelegate.window?.tintColor = UIColor.black
            
            appdelegate.window?.rootViewController = rootNavigationController!
            appdelegate.window?.makeKeyAndVisible()
            
            currentRouteState = AppRouteState.dashboardView
        }
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
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        if appdelegate.apiToken == nil, currentRouteState != .loginView {
            loginViewModel = LoginViewModel.init()
            loginViewController = LoginViewController.initWithViewModel(loginViewModel!)
            appdelegate.window?.rootViewController = loginViewController!
            appdelegate.window?.makeKeyAndVisible()
            currentRouteState = AppRouteState.loginView
        }
    }
}
