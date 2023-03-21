//
//  CharactersAPI.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 21/03/23.
//

import Foundation
import Combine

protocol CharactersFetchable {
    func fetchCharacterList(offset: Int) -> AnyPublisher<CharacterListResponse, APIError>
}

class CharactersAPI {
    private let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }
}

private extension CharactersAPI {
    struct CharactersAPIComponent {
        static let scheme = "https"
        static let host = "gateway.marvel.com"
        static let path = "/v1/public/characters"
        static let apiKey = "8646d8b6ff6d3e387697ef2c7c94ef29"
        static let hash = "342c2dd19c8912a93ce27b1af71f765e"
        static let timestamp = "1"
    }
    
    func urlComponentForCharacterList(offset: Int) -> URLComponents {
        var components = URLComponents()
        components.scheme = CharactersAPIComponent.scheme
        components.host = CharactersAPIComponent.host
        components.path = CharactersAPIComponent.path
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "apikey", value: CharactersAPIComponent.apiKey),
            URLQueryItem(name: "hash", value: CharactersAPIComponent.hash),
            URLQueryItem(name: "ts", value: CharactersAPIComponent.timestamp)
        ]
        
        return components
    }
}


extension CharactersAPI: CharactersFetchable, Fetchable {
    func fetchCharacterList(offset: Int) -> AnyPublisher<CharacterListResponse, APIError> {
        return fetch(with: self.urlComponentForCharacterList(offset: offset), session: self.session)
    }
}
