//
//  GetCollectionResponse.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

public struct GetCollectionResponse: Codable {
    public let elapsedMilliseconds, count: Int
    public let countFacets: CountFacets
    public let artObjects: [ArtObject]
    public let facets: [CategoryFacet]
}
