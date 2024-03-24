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
                Text(emoji.Emoji) // Ensure this is the correct property to display
            }
            .navigationBarTitle("Emojis")
            .onAppear {
                print("DebugNote: ContentView is appearing, calling fetchAllEmojis()")
                emojiManager.fetchAllEmojis()
            }
        }
    }
}

class EmojiRealmManagerObservable: ObservableObject {
    @Published var emojis: [Emoji] = []
    private var emojiRealmManager = EmojiRealmManager()

    func fetchAllEmojis() {
        print("DebugNote: Fetching emojis from EmojiRealmManager")
        emojis = emojiRealmManager.fetchAllEmojis()
    }
}
