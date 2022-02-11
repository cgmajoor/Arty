//
//  ArtImage.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct ArtImage: Codable {
    let guid: String
    let offsetPercentageX, offsetPercentageY, width, height: Int
    let url: String
}
