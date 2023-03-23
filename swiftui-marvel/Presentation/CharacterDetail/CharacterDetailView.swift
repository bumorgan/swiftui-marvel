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
            AsyncImage(url: URL(string: "\(viewModel.character.thumbnail?.path ?? "").\(viewModel.character.thumbnail?.extension ?? "")")) { phase in
                if let image = phase.image {
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Text("Fails to load image")
                } else {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
            }.listRowInsets(EdgeInsets())
            if !viewModel.character.description.isEmpty {
                Section(header: Text(viewModel.character.name)) {
                    Text(viewModel.character.description)
                }
            }
            Section(header: Text("Links")) {
                if let _ = viewModel.character.stories {
                    Text("Stories")
                }
                if let _ = viewModel.character.comics {
                    Text("Comics")
                }
                if let _ = viewModel.character.events {
                    Text("Events")
                }
                if let _ = viewModel.character.series {
                    Text("Series")
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
                                 stories: nil,
                                 comics: nil,
                                 events: nil,
                                 series: nil
                        )
            )
        )
    }
}
