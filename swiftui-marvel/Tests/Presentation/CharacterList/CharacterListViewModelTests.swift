//
//  CharacterListViewModelTests.swift
//  swiftui-marvelTests
//
//  Created by Bruno Morgan on 29/03/23.
//

import Combine
import XCTest
@testable import swiftui_marvel

class CharacterListViewModelTests: XCTestCase {
    var sut: CharacterListViewModel!

    var service: CharacterAPIMock! {
        didSet {
            sut = CharacterListViewModel(charactersFetcher: service)
        }
    }

    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        service = CharacterAPIMock()
    }

    func testfetchCharacterList_WhenFails_ShouldHasFailed() throws {
        // given
        service.expectedResult = .failure(APIError.request(message: "Fail"))
        let expectation = XCTestExpectation(description: "Failed is set")
        sut.$hasFailed.dropFirst().sink { hasFailed in
            XCTAssert(hasFailed)
            expectation.fulfill()
        }.store(in: &cancellables)

        // then
        sut.fetchCharacterList(search: "")

        // when
        wait(for: [expectation], timeout: 1)
    }

    func testFetchCharacterList_WhenSucceed_ShouldLoadedState() {
        // given
        let expectedData = CharacterListResponse.mock
        service.expectedResult = .success(expectedData)
        let expectation = XCTestExpectation(description: "State is loaded")
        sut.$state.dropFirst().sink { state in
            switch state {
            case .loaded(let response):
                XCTAssertEqual(response, expectedData.data.results)
                expectation.fulfill()
            default:
                XCTFail()
            }
        }.store(in: &cancellables)

        // then
        sut.fetchCharacterList(search: "")

        // when
        wait(for: [expectation], timeout: 1)
    }
}
