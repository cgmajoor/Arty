//
//  AppDelegate.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 08/02/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupMainViewController()
        
        return true
    }

    // MARK: - Private

    private func setupMainViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = LibraryViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

