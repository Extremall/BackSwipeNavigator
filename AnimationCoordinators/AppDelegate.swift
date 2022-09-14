//
//  AppDelegate.swift
//  AnimationCoordinators
//
//  Created by Alexander Naumenko on 11/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        
        let firstVC = FirstViewController()
        
        let navVC = BackSwipeNavigationController(rootViewController: firstVC)
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        return true
    }
}

