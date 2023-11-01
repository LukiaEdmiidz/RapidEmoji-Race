//
//  ContentView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//





import SwiftUI

struct ContentView: View {
    // Sample flashcards
//    let flashcards: [Flashcard] = [
//        // ... your 10 sample flashcards here ...
//    ]
    
    // The current flashcard index.
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            FlashcardView(flashcard: flashcards[currentIndex])
            
            HStack {
                Button("Previous") {
                    if currentIndex > 0 {
                        currentIndex -= 1
                    }
                }
                .padding()
                
                Button("Next") {
                    if currentIndex < flashcards.count - 1 {
                        currentIndex += 1
                    }
                }
                .padding()
            }
        }
    }
}


