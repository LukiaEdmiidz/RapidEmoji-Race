//
//  FlashcardView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI

struct FlashcardView: View {
    let flashcard: Flashcard
    
    var body: some View {
        VStack {
            Text(flashcard.word)
                .font(.largeTitle)
                .padding()
            Text(flashcard.emoji)
                .font(.largeTitle)
                .padding()
        }
        .border(Color.black, width: 2)
        .padding()
    }
}



