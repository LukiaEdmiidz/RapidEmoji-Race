//
//  FlashcardView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI

struct FlashcardView: View {
    var flashcard: Flashcard

    var body: some View {
        VStack(spacing: 20) {
            Text(flashcard.emoji)
                .font(.system(size: 200)) // Adjust the size as desired.
                .padding()

            Text(flashcard.word)
                .font(.title)
                .padding()
        }
        .padding()
    }
}




