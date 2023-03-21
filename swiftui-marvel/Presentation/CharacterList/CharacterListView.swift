//
//  CharacterListView.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import SwiftUI

struct CharacterListView<ViewModel>: View where ViewModel: CharacterListViewModelInterface {
    @StateObject private var viewModel: ViewModel
    @State private var searchText: String = ""

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                switch viewModel.state {
                case .loading:
                    ProgressView().onAppear { viewModel.fetchCharacterList(search: searchText) }
                case .loaded(let characterList):
                    createCharacterList(with: characterList, isLastPage: viewModel.isLastPage)
                }
            }
            .navigationTitle("Characters")
            .searchable(text: $searchText)
            .onChange(of: searchText) { newValue in
                viewModel.fetchCharacterList(search: newValue)
            }
        }
        .alert("Something went wrong", isPresented: $viewModel.hasFailed) {
            Button("Try again") {
                viewModel.fetchCharacterList(search: searchText)
            }
        }
    }

    private func createCharacterList(with characterList: [Character], isLastPage: Bool) -> some View {
        List {
            ForEach(characterList) { character in
                Text(character.name)
            }
            if !isLastPage {
                ProgressView()
                    .onAppear { viewModel.fetchCharacterList(search: searchText) }
            }
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel(charactersFetcher: CharactersAPI()))
    }
}
