//
//  Section.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 20/02/2022.
//

import Foundation
import ArtyData

public enum Section: String, CaseIterable {
    case print = "Prints"
    case drawing = "Drawings"
    case painting = "Paintings"

    func getArtType() -> ArtType {
        switch self {
        case .print:
            return ArtType.print
        case .drawing:
            return ArtType.drawing
        case .painting:
            return ArtType.painting
        }
    }
    
}
