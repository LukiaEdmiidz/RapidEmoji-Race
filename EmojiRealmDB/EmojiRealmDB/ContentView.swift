//
//  ContentView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import SwiftUI
// Import RealmSwift if you're directly using Realm objects in this view
// import RealmSwift

struct ContentView: View {
    // Initialize your EmojiRealmManager
    private var emojiManager = EmojiRealmManager()

    // State to hold your fetched emojis
    @State private var emojis: [Emoji] = []

    var body: some View {
        List(emojis, id: \.Emoji) { emoji in
            Text(emoji.Emoji)
        }
        .onAppear {
            // Fetch emojis when the view appears
            emojis = Array(emojiManager.fetchAllEmojis())
        }
        // Additional UI components and functionality here...
    }
}
