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
    static var maxItems = 10000
    public var printArtworks: [Artwork]
    public var drawingArtworks: [Artwork]
    public var paintingArtworks: [Artwork]

    var categories: [ArtCategory]? // principalMaker, type, material, place etc.
    var artTypes: [Facet]? // painting, drawing, print etc.

    var pageSize: Int = 5

    // MARK: - Init
    
    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
        self.printArtworks = [Artwork]()
        self.drawingArtworks = [Artwork]()
        self.paintingArtworks = [Artwork]()
    }

    // MARK: - Init

    public func fetchCollection(_ section: Section,completion: @escaping ((ResponseState<[Artwork]>) -> Void)) {
        completion(ResponseState.loading)
        guard (getCurrentPage(section) * pageSize) < LibraryViewModel.maxItems else { return }
        //print("CurrentPage: \(getCurrentPage(section)) for section: \(section.rawValue)")

        collectionRepository.getCollection(page: getCurrentPage(section), pageSize: pageSize, type: section.getArtType()) { result in
            switch result {
            case .success(let response):
                self.onSuccess(response, section: section, completion: completion)
            case .failure(let error):
                print(error.localizedDescription)
                completion(ResponseState.finished(.failure(error)))
            }
        }
    }

    // MARK: - Helpers

    func getCurrentPage(_ section: Section) -> Int {
        self.getArtworks(section).count / pageSize
    }

    func getArtworks(_ section: Section) -> [Artwork] {
        switch section {
        case .print:
            return printArtworks
        case .drawing:
            return drawingArtworks
        case .painting:
            return paintingArtworks
        }
    }

    // MARK: - Private

    private func onSuccess(_ response: GetCollectionResponse,
                           section: Section,
                           completion: @escaping ((ResponseState<[Artwork]>) -> Void)) {
        switch section {
        case .print:
            printArtworks += response.artObjects.map { Artwork(artObject: $0) }
            completion(ResponseState.finished(.success(printArtworks)))
        case .drawing:
            drawingArtworks += response.artObjects.map { Artwork(artObject: $0) }
            completion(ResponseState.finished(.success(drawingArtworks)))
        case .painting:
            paintingArtworks += response.artObjects.map { Artwork(artObject: $0) }
            completion(ResponseState.finished(.success(paintingArtworks)))
        }

        // categories = response.facets.map { ArtCategory(categoryFacet: $0) }
        // artTypes = self.categories?.first(where: { $0.name == "type" })?.facets
    }
}
