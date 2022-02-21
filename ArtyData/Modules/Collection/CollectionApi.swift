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
    case getCollection(page: Int, pageSize: Int, type: String)
    case getArtObject(objectNumber: String)
}

extension CollectionApi: TargetType {
    public var baseURL: URL { URL(string: ApiEnvironment.baseUrl)! }

    public var path: String {
        switch self {
        case .getCollection:
            return ApiEnvironment.collectionPath
        case .getArtObject(let objectNumber):
            return "\(ApiEnvironment.collectionPath)/\(objectNumber)"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .getCollection, .getArtObject:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .getCollection(let page, let pageSize, let type):
            let dict: [String: Any] = ["p": page,
                                       "ps": pageSize,
                                       "imgonly": "true",
                                       "type": type]
            return .requestParameters(parameters: dict, encoding: URLEncoding.default)
        case .getArtObject:
            return .requestPlain
        }
    }

    public var sampleData: Data {
        switch self {
        case .getCollection:
            return Bundle(for: CollectionRepository.self).getData(type: GetCollectionResponse.self,
                                                                  file: "get-collection",
                                                                  withExtension: "json") ?? Data()
        case .getArtObject:
            return Bundle(for: CollectionRepository.self).getData(type: GetArtObjectResponse.self,
                                                                  file: "get-artobject",
                                                                  withExtension: "json") ?? Data()
        }
    }

    public var headers: [String: String]? {
        return [:]
    }
}
