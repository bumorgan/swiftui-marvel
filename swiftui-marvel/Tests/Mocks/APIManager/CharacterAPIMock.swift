//
//  CharacterAPIMock.swift
//  swiftui-marvelTests
//
//  Created by Bruno Morgan on 29/03/23.
//

import Combine
@testable import swiftui_marvel

class CharacterAPIMock: CharactersFetchable {
    var expectedResult: Result<CharacterListResponse, APIError>!
    
    func fetchCharacterList(offset: Int, search: String) -> AnyPublisher<CharacterListResponse, APIError> {
        expectedResult.publisher.eraseToAnyPublisher()
    }
}
