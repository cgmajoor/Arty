//
//  App+Injection.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation
import Resolver
import ArtyData
import Moya

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph
        
        register { WelcomeRouter() as WelcomeRouting }
        
        register { CollectionRepository(provider: MoyaProvider<CollectionApi>()) }
        // If you don't have an APIKEY for Rijksmuseum
        // you can replace the above line with the one below
        // to use the provider below which will return sample local data
        // register { CollectionRepository(provider:
        // MoyaProvider<CollectionApi>(stubClosure: MoyaProvider.immediatelyStub)) }
        
        register { LibraryViewModel(collectionRepository: $0.resolve()) }
    }
}
