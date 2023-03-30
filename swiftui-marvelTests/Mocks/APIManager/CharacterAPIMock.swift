//
//  CharacterAPIMock.swift
//  swiftui-marvelTests
//
//  Created by Bruno Morgan on 29/03/23.
//

import Combine
@testable import swiftui_marvel

class CharacterAPIMock: CharactersFetchable {
    var expected: AnyPublisher<CharacterListResponse, APIError>!
    
    func fetchCharacterList(offset: Int, search: String) -> AnyPublisher<CharacterListResponse, APIError> {
        expected
    }
}
