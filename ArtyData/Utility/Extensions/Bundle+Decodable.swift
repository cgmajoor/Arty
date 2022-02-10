//
//  Bundle+Decodable.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation

extension Bundle {
    func getData<T: Decodable>(type: T.Type, file: String, withExtension: String) -> Data? {
        guard let filePath = self.path(forResource: file, ofType: withExtension) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        guard let data = try? String(contentsOfFile: filePath).data(using: .utf8) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        return data
    }
}
