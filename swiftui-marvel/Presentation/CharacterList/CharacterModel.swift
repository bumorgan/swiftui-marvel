//
//  CharacterModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation

struct CharacterListResponse: Decodable {
    let copyright: String
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

struct Character: Decodable, Identifiable {
    let id: Int
    let name: String
}
