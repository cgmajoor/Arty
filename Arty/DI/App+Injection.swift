//
//  App+Injection.swift
//  Arty
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        defaultScope = .graph

    }
}
