//
//  LibraryViewModel.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation
import Resolver
import ArtyData

class LibraryViewModel {
    
    // MARK: - Dependencies
    
    @Injected private var collectionRepository: CollectionRepository
    
    // MARK: - Init
    
    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
    }
    
    public func fetchCollection(completion: @escaping ((GetCollectionResponse?, Error?) -> Void)) {
        collectionRepository.getCollection() { result in
            switch result {
            case .success(let response):
                print("\(response)")
                completion(response, nil)
            case .failure(let error):
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
