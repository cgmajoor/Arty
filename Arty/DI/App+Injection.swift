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

        register { CollectionRepository(provider: MoyaProvider<CollectionApi>()) }
        
        register { LibraryViewModel(collectionRepository: $0.resolve()) }
    }
}
