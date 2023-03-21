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
    init(charactersFetcher: CharactersFetchable)
    func fetchCharacterList()
}

class CharacterListViewModel {
    @Published var characterList: [Character]
    private let charactersFetcher: CharactersFetchable
    private var disposables = Set<AnyCancellable>()

    required init(charactersFetcher: CharactersFetchable) {
        self.charactersFetcher = charactersFetcher
        self.characterList = [Character]()
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterListViewModel: CharacterListViewModelInterface {
    func fetchCharacterList() {
        charactersFetcher
            .fetchCharacterList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let error):
                    self?.characterList = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.characterList = response.data.results
            }
            .store(in: &disposables)
    }
}
