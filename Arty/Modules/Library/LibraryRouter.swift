//
//  LibraryRouter.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import Foundation

protocol LibraryRouting {
    func didSelectArtwork(objectNumber: String, in viewController: LibraryViewController)
}

class LibraryRouter: LibraryRouting {
    func didSelectArtwork(objectNumber: String, in viewController: LibraryViewController) {
        let artworkVC = ArtworkViewController(objectNumber: objectNumber)
        viewController.navigationController?.pushViewController(artworkVC, animated: true)
    }
}
