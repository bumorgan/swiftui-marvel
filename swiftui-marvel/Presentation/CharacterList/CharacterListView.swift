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
                ProgressView().onAppear(perform: viewModel.fetchCharacterList)
            case .loaded(let characterList):
                createCharacterList(with: characterList, isLastPage: viewModel.isLastPage)
            }
        }
        .alert("Something went wrong", isPresented: $viewModel.hasFailed) {
            Button("Try again") {
                viewModel.fetchCharacterList()
            }
        }
    }

    private func createCharacterList(with characterList: [Character], isLastPage: Bool) -> some View {
        VStack {
            List {
                ForEach(characterList) { character in
                    Text(character.name)
                }
                if !isLastPage {
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
