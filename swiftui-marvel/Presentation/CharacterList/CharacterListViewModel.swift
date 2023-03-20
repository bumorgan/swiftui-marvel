//
//  CharacterListViewModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation
import Combine

protocol CharacterListViewModelInterface: ObservableObject {
    var characterList: [Character] { get set }
}

class CharacterListViewModel {
    @Published var characterList: [Character] = [Character(id: "1", name: "Spider-Man"),
                                                 Character(id: "2", name: "Hulk")]
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterListViewModel: CharacterListViewModelInterface { }
