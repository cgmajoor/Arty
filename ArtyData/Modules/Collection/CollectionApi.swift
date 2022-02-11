//
//  CollectionApi.swift
//  ArtyData
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Moya

public enum ApiEnvironment {
    static let apiKey = "APIKEY"
    static let baseUrl = "https://www.rijksmuseum.nl?key=\(apiKey)"
    static let collectionPath = "/api/en/collection"
}

public enum CollectionApi {
    case getCollection(page: Int, pageSize: Int)
}

extension CollectionApi: TargetType {
    public var baseURL: URL { URL(string: ApiEnvironment.baseUrl)! }

    public var path: String {
        switch self {
        case .getCollection:
            return ApiEnvironment.collectionPath
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getCollection:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getCollection(let page, let pageSize):
            let dict: [String: Any] = ["p": page,
                                       "ps": pageSize,
                                       "imgonly": "true"]
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        }
    }

    public var sampleData: Data {
        switch self {
        case .getCollection:
            
            return Bundle(for: CollectionRepository.self).getData(type: GetCollectionResponse.self,
                                                                  file: "get-collection",
                                                                  withExtension: "json") ?? Data()
        }
    }

    public var headers: [String: String]? {
        return [:]
    }
}
