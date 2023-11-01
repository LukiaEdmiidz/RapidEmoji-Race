//
//  ContentView.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//






import SwiftUI

struct ContentView: View {
    // Sample data to work with.
 
    
    // The current flashcard index.
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            Text(flashcards[currentIndex].emoji)
                .font(.largeTitle)
                .padding()
            
            Text(flashcards[currentIndex].word)
                .font(.title)
                .padding()
            
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


