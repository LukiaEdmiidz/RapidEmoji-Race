//
//  ContentView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var emojiManager = EmojiRealmManagerObservable()

    var body: some View {
        NavigationView {
            List(emojiManager.emojis, id: \.Emoji) { emoji in
                Text(emoji.Emoji)
            }
            .navigationBarTitle("Emojis", displayMode: .inline)
            .onAppear {
                emojiManager.fetchAllEmojis()
            }
        }
    }
}

// Make EmojiRealmManager conform to ObservableObject for SwiftUI integration
class EmojiRealmManagerObservable: ObservableObject {
    @Published var emojis: [Emoji] = []

    private var emojiRealmManager = EmojiRealmManager()

    func fetchAllEmojis() {
        emojis = emojiRealmManager.fetchAllEmojis()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
