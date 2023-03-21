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
    var isLastPage: Bool { get set }
    var lastItemId: Int { get set }
    init(charactersFetcher: CharactersFetchable)
    func fetchCharacterList()
}

class CharacterListViewModel {
    @Published var state: ViewModelState<[Character]>
    @Published var isLastPage: Bool
    @Published var lastItemId: Int
    private let charactersFetcher: CharactersFetchable
    private var disposables = Set<AnyCancellable>()

    private var offset = 0 {
        didSet {
            isLastPage = offset < 0
        }
    }
    private var characterList: [Character] {
        didSet {
            lastItemId = characterList.last?.id ?? -1
            state = .loaded(characterList)
        }
    }

    required init(charactersFetcher: CharactersFetchable) {
        self.charactersFetcher = charactersFetcher
        self.state = .idle
        self.characterList = [Character]()
        self.isLastPage = false
        self.lastItemId = -1
    }
}

//MARK: - CharacterListViewModelInterface Extension

extension CharacterListViewModel: CharacterListViewModelInterface {
    func fetchCharacterList() {
        guard offset >= 0 else { return }
        if offset == 0 {
            state = .loading
        }
        charactersFetcher
            .fetchCharacterList(offset: offset)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                switch value {
                case .failure(let error):
                    self?.state = .failed(error)
                case .finished:
                    break
                }
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.offset += response.data.limit
                if self.offset > response.data.total {
                    self.offset = -1
                }
                self.characterList.append(contentsOf: response.data.results)
            }
            .store(in: &disposables)
    }
}
