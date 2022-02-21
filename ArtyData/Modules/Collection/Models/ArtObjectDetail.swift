//
//  ArtObjectDetail.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import Foundation

public struct ArtObjectDetail: Codable {
    public let id, objectNumber: String
    public let title: String
    public let webImage: ArtImage
}

// MARK: - ArtObjectDetailPage
public struct ArtObjectDetailPage: Codable {
    public let id: String
    public let lang, objectNumber: String
    public let plaqueDescription: String
    public let createdOn, updatedOn: String
}
