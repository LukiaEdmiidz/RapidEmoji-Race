//
//  ContentView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    @State private var flashcards: [Flashcard] = []

    // Initialize the speech synthesizer
    private let synthesizer = AVSpeechSynthesizer()

    // The language to use, passed from the StartScreenView
    var language: String

    var body: some View {
        VStack(spacing: 20) {
            // The emoji card
            if !flashcards.isEmpty {
                ZStack {
                    FlashcardView(flashcard: flashcards[currentIndex], showWord: showWord)

                    // No gestures here for now
                }
            } else {
                Text("No more flashcards to display")
                    .font(.title)
                    .padding()
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

    // Function to go to the next card
    func nextCard() {
        if !flashcards.isEmpty {
            let emojiManager = EmojiRealmManager()

            // Explicitly pass the closure
            emojiManager.incrementViewed(for: flashcards[currentIndex].emoji, completion: {
                self.loadFlashcards() // Try without DispatchQueue.main.async for now
            })

            currentIndex = (currentIndex + 1) % flashcards.count
        }
    }

    func previousCard() {
        if !flashcards.isEmpty {
            let emojiManager = EmojiRealmManager()

            // Explicitly pass the closure
            emojiManager.incrementViewed(for: flashcards[currentIndex].emoji, completion: {
                self.loadFlashcards() // Try without DispatchQueue.main.async for now
            })

            currentIndex = currentIndex > 0 ? currentIndex - 1 : flashcards.count - 1
        }
    }

    // Increment the Known_Count of a flashcard
    func incrementKnownCount(for flashcard: Flashcard) {
        let emojiManager = EmojiRealmManager()
        emojiManager.incrementKnownCount(for: flashcard.emoji)
        flashcards[currentIndex].knownCount += 1
    }

    // Delete a flashcard from the Realm and the current list
    func deleteCard(flashcard: Flashcard) {
        let emojiManager = EmojiRealmManager()
        emojiManager.deleteEmoji(flashcard.emoji)
        flashcards.remove(at: currentIndex)
        if currentIndex >= flashcards.count {
            currentIndex = 0
        }
    }

    // Function to load the flashcards from the Realm database
    func loadFlashcards() {
        let emojiManager = EmojiRealmManager()
        let emojis = emojiManager.fetchFilteredEmojis()

        // Remove DispatchQueue.main.async for now
        self.flashcards = emojis.map {
            Flashcard(emoji: $0.Emoji,
                      english: $0.English,
                      knownCount: $0.Known_Count,
                      frequency: $0.frequency,
                      viewed: $0.Viewed)
        }
    }

    // Function to speak the emoji in the selected language
    func speakText(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
