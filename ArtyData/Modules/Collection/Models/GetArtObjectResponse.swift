//
//  GetArtObjectResponse.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import Foundation

public struct GetArtObjectResponse: Codable {
    public let elapsedMilliseconds: Int
    public let artObject: ArtObjectDetail
    public let artObjectPage: ArtObjectDetailPage
}
