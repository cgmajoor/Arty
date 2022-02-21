//
//  Artwork.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import Foundation
import ArtyData
import UIKit

struct Artwork: Hashable {
    let objectNumber: String
    let title: String
    let imageUrl: String
    private let identifier: UUID

    public init(artObject: ArtObject) {
        self.objectNumber = artObject.objectNumber
        self.title = artObject.title
        self.imageUrl = artObject.webImage.url
        self.identifier = UUID(uuidString: artObject.id) ?? UUID()
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }
}
