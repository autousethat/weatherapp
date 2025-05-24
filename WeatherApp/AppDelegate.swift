//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Oleg Antonov on 5/24/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = RootViewController()
        self.window = window
        self.window!.makeKeyAndVisible()
        return true
    }

}

