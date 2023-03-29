//
//  CharacterDetailViewModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 21/03/23.
//

import Foundation
import Combine

protocol CharacterDetailViewModelInterface: ObservableObject {
    var character: Character { get set }
    var hasLinks: Bool { get }
}

class CharacterDetailViewModel {
    @Published var character: Character

    var hasLinks: Bool {
        [character.series, character.events, character.stories, character.comics].compactMap { $0 }.count > 0
    }

    required init(character: Character) {
        self.character = character
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterDetailViewModel: CharacterDetailViewModelInterface { }
