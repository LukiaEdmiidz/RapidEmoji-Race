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
                Text("Known Count: \(flashcard.knownCount)")
                    .font(.title3) // Smaller font size
                    .padding(.bottom, 5) // Adjust padding as needed
                
                Text("Frequency: \(flashcard.frequency)")
                    .font(.body) // Smaller font size
                    .padding(.bottom, 5) // Adjust padding as needed

                Text("Viewed: \(flashcard.viewed)")
                    .font(.body) // Smaller font size
                    .padding(.bottom, 5) // Adjust padding as needed



            // if showWord {  // Only show the word if showWord is true
            //     Text(flashcard.english)
            //         .font(.title)
            //         .padding()
            // }
        }
        .padding()
    }
}

struct Flashcard {
    var emoji: String
    var english: String
    var knownCount: Int
    var frequency: Int
    var viewed: Int
}







