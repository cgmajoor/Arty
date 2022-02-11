//
//  CategoryFacet.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct CategoryFacet: Codable {
    public let facets: [Facet]
    public let name: String
    public let otherTerms, prettyName: Int
}
