//
//  FlashcardView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI

struct FlashcardView: View {
    var flashcard: Flashcard
    var showWord: Bool  // Added this to control word display

    var body: some View {
        VStack(spacing: 20) {
            Text(flashcard.emoji)
                .font(.system(size: 200)) // Adjust the size as desired.
                .padding()

            if showWord {  // Only show the word if showWord is true
                Text(flashcard.word)
                    .font(.title)
                    .padding()
            }
        }
        .padding()
    }
}





