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
        ResponseData(offset: 0, limit: 0, total: 0, count: 0, results: [])
    }
}
