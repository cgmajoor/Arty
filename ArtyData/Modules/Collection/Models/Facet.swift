//
//  Facet.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct Facet: Codable {
    public let facetKey: String
    public let facetValue: Int

    enum CodingKeys: String, CodingKey {
        case facetKey = "key"
        case facetValue = "value"
    }
}
