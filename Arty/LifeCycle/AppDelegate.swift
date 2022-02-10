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
        let viewController = WelcomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.backgroundColor = .white
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

