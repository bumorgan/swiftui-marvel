//
//  CharacterModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation

struct CharacterListResponse: Decodable {
    let attributionText: String
    let data: ResponseData
}

struct ResponseData: Decodable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [Character]
}

struct Character: Decodable, Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String
    let thumbnail: Thumbnail?
    let stories: CharacterItem?
    let comics: CharacterItem?
    let events: CharacterItem?
    let series: CharacterItem?
}

struct Thumbnail: Decodable, Equatable {
    let path: String?
    let `extension`: String?
}

struct CharacterItem: Decodable, Equatable {
    let available: Int
    let collectionURI: String
}
