//
//  WelcomeRouter.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

protocol WelcomeRouting {
    func didSelectLibrary(in viewController: WelcomeViewController)
}

class WelcomeRouter: WelcomeRouting {
    func didSelectLibrary(in viewController: WelcomeViewController) {
        let libraryVC = LibraryViewController()
        viewController.navigationController?.pushViewController(libraryVC, animated: true)
    }
}
