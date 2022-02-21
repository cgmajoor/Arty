//
//  CollectionRepository.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Moya

public enum ArtType: String {
    case print
    case drawing
    case painting
}

public class CollectionRepository {
    
    let provider: MoyaProvider<CollectionApi>
    
    public init(provider: MoyaProvider<CollectionApi>) {
        self.provider = provider
    }
    
    public func getCollection(page: Int,
                              pageSize: Int,
                              type: ArtType,
                              completion: @escaping ((Result<GetCollectionResponse, Error>) -> Void)) {
        provider.request(.getCollection(page: page, pageSize: pageSize, type: type.rawValue)) { result in
            do {
                let data = try result.get().data
                let response = try JSONDecoder().decode(GetCollectionResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    public func getArtObject(objectNumber: String,
                             completion: @escaping ((Result<GetArtObjectResponse, Error>) -> Void)) {
        provider.request(.getArtObject(objectNumber: objectNumber)) { result in
            do {
                let data = try result.get().data
                let response = try JSONDecoder().decode(GetArtObjectResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
