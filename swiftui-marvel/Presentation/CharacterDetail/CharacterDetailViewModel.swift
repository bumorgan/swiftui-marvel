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
}

class CharacterDetailViewModel {
    @Published var character: Character

    required init(character: Character) {
        self.character = character
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterDetailViewModel: CharacterDetailViewModelInterface { }
