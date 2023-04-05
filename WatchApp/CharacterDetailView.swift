//
//  CharacterDetailView.swift
//  watch-swiftui-marvel Watch App
//
//  Created by Bruno Morgan on 04/04/23.
//

import SwiftUI

struct CharacterDetailView: View {
    private let character = Character(id: 1,
                                      name: "Hulk",
                                      description: "Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.",
                                      thumbnail: Thumbnail(
                                         path: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0",
                                         extension: "jpg"
                                      )
                             )
    
    var body: some View {
        List {
            AsyncImage(url: URL(string: "\(character.thumbnail?.path ?? "").\(character.thumbnail?.extension ?? "")")) { phase in
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
            if !character.description.isEmpty {
                Section(header: Text(character.name)) {
                    Text(character.description)
                }
            }
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}
