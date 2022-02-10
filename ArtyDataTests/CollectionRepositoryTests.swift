//
//  CollectionRepositoryTests.swift
//  ArtyDataTests
//
//  Created by Ceren Gazioglu Majoor on 10/02/2022.
//

import XCTest
import Moya
@testable import ArtyData

class CollectionRepositoryTests: XCTestCase {


    func testGetCollectionSuccesful() throws {
        let stubbingProvider = MoyaProvider<CollectionApi>(stubClosure: MoyaProvider.immediatelyStub)
        let collectionRepository = CollectionRepository(provider: stubbingProvider)
        let getCollectionExpectation = expectation(description: "getCollection")
        
        collectionRepository.getCollection { result in
            switch result {
            case .success(let response):
                XCTAssert(response.artObjects.count == 10)
                getCollectionExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }

}
