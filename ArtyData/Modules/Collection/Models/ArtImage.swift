//
//  ArtImage.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct ArtImage: Codable {
    public let guid: String
    public let offsetPercentageX, offsetPercentageY, width, height: Int
    public let url: String
}
