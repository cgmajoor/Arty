//
//  ArtworkViewModel.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 21/02/2022.
//

import Foundation
import Resolver
import ArtyData

class ArtworkViewModel {

    // MARK: - Dependencies

    private let collectionRepository: CollectionRepository

    // MARK: - Properties
    public var artworkDetail: ArtworkDetail?

    // MARK: - Init

    init(collectionRepository: CollectionRepository) {
        self.collectionRepository = collectionRepository
    }

    // MARK: - Init

    public func fetchArtworkDetail(_ objectNumber: String,
                                   completion: @escaping ((ResponseState<ArtworkDetail>) -> Void)) {
        completion(ResponseState.loading)

        collectionRepository.getArtObject(objectNumber: objectNumber) { result in
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

    private func onSuccess(_ response: GetArtObjectResponse,
                           completion: @escaping ((ResponseState<ArtworkDetail>) -> Void)) {
        let artworkDetail = ArtworkDetail(id: response.artObject.id,
                                          objectNumber: response.artObject.objectNumber,
                                          title: response.artObject.title,
                                          imageUrl: response.artObject.webImage.url)

        completion(ResponseState.finished(.success(artworkDetail)))
    }
}
