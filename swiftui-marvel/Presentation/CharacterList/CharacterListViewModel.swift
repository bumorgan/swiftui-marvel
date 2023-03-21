//
//  CharacterListViewModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation
import Combine

enum ViewModelState<T> {
    case idle
    case loading
    case failed(Error)
    case loaded(T)
}

protocol CharacterListViewModelInterface: ObservableObject {
    var state: ViewModelState<[Character]> { get set }
    init(charactersFetcher: CharactersFetchable)
    func fetchCharacterList()
}

class CharacterListViewModel {
    @Published var state: ViewModelState<[Character]>
    private let charactersFetcher: CharactersFetchable
    private var disposables = Set<AnyCancellable>()

    required init(charactersFetcher: CharactersFetchable) {
        self.charactersFetcher = charactersFetcher
        self.state = .idle
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterListViewModel: CharacterListViewModelInterface {
    func fetchCharacterList() {
        state = .loading
        charactersFetcher
            .fetchCharacterList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let error):
                    self?.state = .failed(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                self?.state = .loaded(response.data.results)
            }
            .store(in: &disposables)
    }
}
