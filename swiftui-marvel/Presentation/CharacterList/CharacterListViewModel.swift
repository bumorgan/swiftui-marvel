//
//  CharacterListViewModel.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import Foundation
import Combine

enum ViewModelState<T> {
    case loading
    case loaded(T)
}

protocol CharacterListViewModelInterface: ObservableObject {
    var state: ViewModelState<[Character]> { get set }
    var isLastPage: Bool { get set }
    var hasFailed: Bool { get set }
    init(charactersFetcher: CharactersFetchable)
    func fetchCharacterList(search: String)
}

class CharacterListViewModel {
    @Published var state: ViewModelState<[Character]> = .loading
    @Published var isLastPage = false
    @Published var hasFailed = false

    private let charactersFetcher: CharactersFetchable
    private var disposables = Set<AnyCancellable>()

    private var offset = 0 {
        didSet {
            isLastPage = offset < 0
        }
    }
    private var characterList = [Character]() {
        didSet {
            state = .loaded(characterList)
        }
    }

    private var search: String = "" {
        didSet {
            if search != oldValue {
                offset = 0
                characterList.removeAll()
                state = .loading
            }
        }
    }

    required init(charactersFetcher: CharactersFetchable) {
        self.charactersFetcher = charactersFetcher
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterListViewModel: CharacterListViewModelInterface {
    func fetchCharacterList(search: String) {
        self.search = search
        guard offset >= 0 else { return }
        disposables.removeAll()
        charactersFetcher
            .fetchCharacterList(offset: offset, search: self.search)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure:
                    self?.hasFailed = true
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                let data = response.data
                self.offset += data.limit
                if self.offset > data.total {
                    self.offset = -1
                }
                self.characterList.append(contentsOf: data.results)
            }
            .store(in: &disposables)
    }
}
