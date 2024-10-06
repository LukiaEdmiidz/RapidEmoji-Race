//
//  FlashcardView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI
import RealmSwift

struct FlashcardView: View {
    var flashcard: Flashcard  // Ensure this is the Realm Object
    var showWord: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text(flashcard.emoji)
                .font(.system(size: 100)) // Adjust the font size as needed
            if showWord {
                Text(flashcard.word)
                    .font(.title)
            }
        }
    }
}






