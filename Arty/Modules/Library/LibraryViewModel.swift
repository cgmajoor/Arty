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

    private let collectionRepository: CollectionRepository

    // MARK: - Properties
    public var artworks: [Artwork]
    public var categories: [ArtCategory]? // principalMaker, type, material, place etc.
    public var artTypes: [Facet]? // painting, drawing, print etc.

    var pageSize: Int = 10
    var currentPage: Int {
        return artworks.count / pageSize
    }

    // MARK: - Init
    
    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
        self.artworks = [Artwork]()
    }

    // MARK: - Init

    public func fetchCollection(completion: @escaping ((ResponseState<GetCollectionResponse>) -> Void)) {
        completion(ResponseState.loading)
        collectionRepository.getCollection(page: currentPage, pageSize: pageSize) { result in
            switch result {
            case .success(let response):
                self.onSuccess(response, completion: completion)
            case .failure(let error):
                print(error.localizedDescription)
                completion(ResponseState.finished(.failure(error)))
            }
        }
    }

    // MARK: - Private

    private func onSuccess(_ response: GetCollectionResponse,
                           completion: @escaping ((ResponseState<GetCollectionResponse>) -> Void)) {
        let lastFetchedArtworks = response.artObjects.map { Artwork(artObject: $0) }
        self.artworks += lastFetchedArtworks
        self.categories = response.facets.map { ArtCategory(categoryFacet: $0) }
        self.artTypes = self.categories?.first(where: {$0.name == "type"})?.facets


        completion(ResponseState.finished(.success(response)))
    }
}
