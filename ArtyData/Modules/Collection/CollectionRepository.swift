//
//  CollectionRepository.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Moya

public class CollectionRepository {

    let provider: MoyaProvider<CollectionApi>
    
    public init(provider: MoyaProvider<CollectionApi>) {
        self.provider = provider
    }

    public func getCollection(page: Int,
                              pageSize: Int,
                              completion: @escaping ((Result<GetCollectionResponse, Error>) -> Void)) {
        provider.request(.getCollection(page: page, pageSize: pageSize)) { result in
            do {
                let data = try result.get().data
                let response = try JSONDecoder().decode(GetCollectionResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
