//ContentView.swift

import SwiftUI
import RealmSwift  // Make sure to import RealmSwift

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero
    @ObservedResults(Flashcard.self) var flashcards  // Fetch flashcards from Realm

    var body: some View {
        VStack(spacing: 20) {
            // Safely access the current flashcard
            if let flashcard = flashcards[safe: currentIndex] {
                // Debugging: Print the current flashcard to ensure data is fetched
                Text("Debug: \(flashcard.emoji) - \(flashcard.word)")
                    .onAppear {
                        print("Current Flashcard: \(flashcard.emoji) - \(flashcard.word)")
                    }
                FlashcardView(flashcard: flashcard, showWord: showWord)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                self.offset = gesture.translation
                            }
                            .onEnded { _ in
                                if self.offset.width > 100 || self.offset.width < -100 {
                                    self.showWord = false  // Hide the word for the next card
                                    self.nextCard()
                                }
                                self.offset = .zero
                            }
                    )
                    .simultaneousGesture(TapGesture()
                        .onEnded { _ in
                            self.showWord.toggle()
                        }
                    )
         } else {
            // Debugging: This will be shown if no flashcards are fetched
            Text("No flashcards available")
                .onAppear {
                    print("No flashcards fetched from Realm")
                }
        }

            // Show hint when the word is not shown
            if !showWord {
                Text("Tap to reveal word!")
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.gray)
            }

            // Add timestamp information
            Text("Built on: \(Date(), formatter: dateFormatter)")
                .font(.system(size: 12))
                .padding(.top)
        }
        .padding(.top, 50)
        .onAppear {
            showWord = false
        }
    }

    func nextCard() {
        currentIndex = (currentIndex + 1) % flashcards.count  // Loop back to the first card if at the end
    }
}

// Extension to safely access elements in a Realm Results collection
extension Results {
    subscript(safe index: Int) -> Element? {
        return (startIndex <= index && index < endIndex) ? self[index] : nil
    }
}

// Date formatter for the timestamp
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .none
    return formatter
}()
