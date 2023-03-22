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
        List {
            AsyncImage(
                url: URL(string: "\(viewModel.character.thumbnail?.path ?? "").\(viewModel.character.thumbnail?.extension ?? "")"),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                },
                placeholder: {
                    ProgressView()
                }
            )
            if !viewModel.character.description.isEmpty {
                Section(header: Text(viewModel.character.name)) {
                    Text(viewModel.character.description)
                }
            }
            if let items = viewModel.character.stories?.items {
                Section(header: Text("Stories")) {
                    ForEach(items, id: \.resourceURI) { item in
                        Text(item.name)
                    }
                }
            }
        }
        .navigationBarTitle(viewModel.character.name)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(
            viewModel: CharacterDetailViewModel(
            character: Character(id: 1,
                                 name: "Hulk",
                                 description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                                 thumbnail: Thumbnail(
                                    path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0",
                                    extension: "jpg"
                                 ),
                                 stories: nil
                        )
            )
        )
    }
}
