//
//  ArtworkDetail.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import ArtyData
import UIKit

struct ArtworkDetail {
    let id: String
    let objectNumber: String
    let title: String
    let imageUrl: String
    
    public init(id: String,
                objectNumber: String,
                title: String,
                imageUrl: String) {
        self.id = id
        self.objectNumber = objectNumber
        self.title = title
        self.imageUrl = imageUrl
    }
}
