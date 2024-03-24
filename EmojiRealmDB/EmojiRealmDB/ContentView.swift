//
//  ContentView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import SwiftUI
import AVFoundation  // Import for TTS functionality

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero
    @State private var flashcards: [Flashcard] = []
    
    // Initialize the speech synthesizer
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 20) {
            // The emoji card
            if !flashcards.isEmpty {
                FlashcardView(flashcard: flashcards[currentIndex], showWord: showWord)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { _ in
                                if abs(self.offset.width) > 100 { // swiped
                                    self.showWord = false
                                    self.nextCard()
                                }
                                self.offset = .zero
                            }
                    )
                    .simultaneousGesture(TapGesture().onEnded { _ in
                        self.showWord.toggle()
                    })
            }

            // Conditionally render the word or the hint
            if showWord && !flashcards.isEmpty {
                Text(flashcards[currentIndex].english) // Show the English word
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
            self.loadFlashcards()
        }
    }

    func nextCard() {
        if currentIndex < flashcards.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }

    func loadFlashcards() {
        // Instantiate your EmojiRealmManager and fetch emojis
        let emojiManager = EmojiRealmManager()
        let emojis = emojiManager.fetchAllEmojis()

        // Map your emojis to Flashcard structs
        self.flashcards = emojis.map { Flashcard(emoji: $0.Emoji, english: $0.English) }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}