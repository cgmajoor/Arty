//
//  CollectionRepository.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Moya

public class CollectionRepository {
    
    let provider: MoyaProvider<CollectionApi>
    
    public required init(provider: MoyaProvider<CollectionApi>) {
        self.provider = provider
    }

    public func getCollection(_ completion: @escaping ((Result<GetCollectionResponse, Error>) -> Void)) {
        provider.request(.getCollection) { result in
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
