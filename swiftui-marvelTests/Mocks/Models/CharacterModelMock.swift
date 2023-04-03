//
//  CharacterModelMock.swift
//  swiftui-marvelTests
//
//  Created by Bruno Morgan on 29/03/23.
//

@testable import swiftui_marvel

extension CharacterListResponse {
    static var mock: CharacterListResponse {
        CharacterListResponse(attributionText: "", data: .mock)
    }
}

extension ResponseData {
    static var mock: ResponseData {
        ResponseData(offset: 0, limit: 0, total: 0, count: 0, results: [.mock])
    }
}

extension Character {
    static var mock: Character {
        Character(id: 1,
                  name: "Hulk",
                  description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                  thumbnail: Thumbnail(
                    path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0",
                    extension: "jpg"
                  )
        )
    }
}
