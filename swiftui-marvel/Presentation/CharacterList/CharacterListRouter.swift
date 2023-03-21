//
//  CharacterListRouter.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 21/03/23.
//

import SwiftUI

enum CharacterListRouter {
    static func makeCharacterDetailView(with character: Character) -> some View {
        let viewModel = CharacterDetailViewModel(character: character)
        let view = CharacterDetailView(viewModel: viewModel)
        return view
    }
}
