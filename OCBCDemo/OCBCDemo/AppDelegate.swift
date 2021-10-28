//
//  AppDelegate.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 27/10/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var apiToken: String?
    
    var viewController: ViewController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let storyBoardRef = UIStoryboard.init(name: "Main", bundle: nil)
        window?.rootViewController = storyBoardRef.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        window?.makeKeyAndVisible()
        return true
    }
}

