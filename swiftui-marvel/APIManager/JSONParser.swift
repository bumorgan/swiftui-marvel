//
//  JSONParser.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, APIError> {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .secondsSince1970

    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(message: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
