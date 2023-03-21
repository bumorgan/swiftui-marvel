//
//  swiftui_marvelApp.swift
//  swiftui-marvel
//
//  Created by Bruno Morgan on 20/03/23.
//

import SwiftUI

@main
struct swiftui_marvelApp: App {
    var body: some Scene {
        WindowGroup {
            CharacterListView(viewModel: CharacterListViewModel(charactersFetcher: CharactersAPI()))
        }
    }
}
