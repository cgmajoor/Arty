//
//  Artwork.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import Foundation
import ArtyData

// MARK: - Artwork

public struct Artwork: Codable {
    let artObject: ArtObject

    public init(artObject: ArtObject) {
        self.artObject = artObject
    }
}
