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

    func testGetCollectionWithLocalDataSuccesful() throws {
        let stubbingProvider = MoyaProvider<CollectionApi>(stubClosure: MoyaProvider.immediatelyStub)
        let collectionRepository = CollectionRepository(provider: stubbingProvider)
        
        collectionRepository.getCollection(page: 0, pageSize: 10) { result in
            switch result {
            case .success(let response):
                XCTAssert(response.artObjects.count == 10)
                XCTAssertEqual(response.artObjects.first?.id, "en-BK-1983-15")
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
    }

    // For this test to work you need to fill API_KEY in CollectionApi
    func testGetCollectionWithPageSizeTwentyReturnsTwentyItems() throws {
        let stubbingProvider = MoyaProvider<CollectionApi>(stubClosure: MoyaProvider.neverStub)
        let collectionRepository = CollectionRepository(provider: stubbingProvider)
        let getCollectionExpectation = expectation(description: "getCollection")
        
        collectionRepository.getCollection(page: 0, pageSize: 20) { result in
            switch result {
            case .success(let response):
                XCTAssert(response.artObjects.count == 20)
                getCollectionExpectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
