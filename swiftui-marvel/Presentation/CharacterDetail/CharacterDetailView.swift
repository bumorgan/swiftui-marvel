//
//  CharacterDetailView.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 21/03/23.
//

import SwiftUI

struct CharacterDetailView<ViewModel>: View where ViewModel: CharacterDetailViewModelInterface {
    @StateObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        Text(viewModel.character.name)
            .navigationBarTitle(viewModel.character.name)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            viewModel: CharacterDetailViewModel(
            character: Character(id: 1,
                                 name: "Spider-man",
                                 description: "The greated Marvel superhero",
                                 thumbnail: Thumbnail(
                                    path: "",
                                    extension: "jpg"
                                 )
                        )
            )
        )
    }
}
