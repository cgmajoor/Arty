//
//  ArtObject.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct ArtObject: Codable {
    public let links: Links
    public let id, objectNumber, title: String
    public let hasImage: Bool
    public let principalOrFirstMaker, longTitle: String
    public let showImage, permitDownload: Bool
    public let webImage, headerImage: ArtImage
    public let productionPlaces: [String]
}
