//
//  AppDelegate.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 27/10/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var apiToken: String?
    var router:RouterProtocol = Router.sharedInstance
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        router.launch()
        return true
    }
}
