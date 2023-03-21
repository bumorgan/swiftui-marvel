//
//  CharacterListView.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelInterface {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.state {
            case .idle:
                Color.clear.onAppear(perform: viewModel.fetchCharacterList)
            case .loading:
                createLoading()
            case .failed:
                Color.clear
            case .loaded(let characterList):
                createCharacterList(with: characterList)
            }
        }
    }

    private func createLoading() -> some View {
        ProgressView()
    }

    private func createCharacterList(with characterList: [Character]) -> some View {
        VStack {
            List(characterList, id: \.id) { character in
                Text(character.name)
                if !viewModel.isLastPage && character.id == viewModel.lastItemId {
                    ProgressView()
                        .onAppear {
                            viewModel.fetchCharacterList()
                        }
                }
            }
        }
        .navigationBarTitle("Characters")
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel(charactersFetcher: CharactersAPI()))
    }
}
