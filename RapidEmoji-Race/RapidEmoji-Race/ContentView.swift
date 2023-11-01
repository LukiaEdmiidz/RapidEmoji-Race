//
//  ContentView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//





import SwiftUI

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 20) {
            // The emoji card
            FlashcardView(flashcard: flashcards[currentIndex])
                .onTapGesture {
                    showWord.toggle()
                }

            // Conditionally render the word or the hint
            if showWord {
                Text(flashcards[currentIndex].word)
                    .font(.title)
                    .padding()
            } else {
                Text("Tap to reveal word")
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.gray)
            }

        }
        .padding(.top, 50)  // Add padding to the top
        .onAppear {
            showWord = false
        }
    }
}



