//
//  ArtCategory.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 11/02/2022.
//

import Foundation
import ArtyData

public struct ArtCategory: Codable {
    let facets: [Facet]
    let name: String

    public init(categoryFacet: CategoryFacet) {
        self.facets = categoryFacet.facets
        self.name = categoryFacet.name
    }
}
