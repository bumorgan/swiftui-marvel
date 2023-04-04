//
//  ContentView.swift
//  watch-swiftui-marvel Watch App
//
//  Created by Bruno Morgan on 04/04/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            AsyncImage(url: URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/5/a0/538615ca33ab0.jpg")) { phase in
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
            Section(header: Text("Hulk")) {
                Text("Caught in a gamma bomb explosion while trying to save the life of a teenager, Dr. Bruce Banner was transformed into the incredibly powerful creature called the Hulk. An all too often misunderstood hero, the angrier the Hulk gets, the stronger the Hulk gets.")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
