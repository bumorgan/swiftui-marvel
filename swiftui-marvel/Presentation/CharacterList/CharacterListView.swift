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
            ScrollView {
                VStack {
                    ForEach(viewModel.characterList) { character in
                        Text(character.name)
                    }
                }
            }
            .navigationBarTitle("Characters")
        }
    }
}

struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView(viewModel: CharacterListViewModel())
    }
}
