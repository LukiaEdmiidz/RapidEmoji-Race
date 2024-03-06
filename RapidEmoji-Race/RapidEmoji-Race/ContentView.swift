import SwiftUI
import Foundation

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero

    var body: some View {
        VStack(spacing: 20) {
            // The emoji card
            FlashcardView(flashcard: flashcards[currentIndex], showWord: showWord)
                .offset(offset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            self.offset = gesture.translation
                        }
                        .onEnded { _ in
                            if self.offset.width > 100 { // swiped right
                                self.showWord = false
                                self.nextCard()
                            } else if self.offset.width < -100 { // swiped left
                                self.showWord = false
                                self.nextCard()
                            }
                            self.offset = .zero
                        }
                )
                .simultaneousGesture(TapGesture()
                    .onEnded { _ in
                        self.showWord.toggle()
                    })

            // Conditionally render the word or the hint
            if showWord {
                // ... your existing code ...
            } else {
                Text("Tap to reveal word!")
                    .font(.subheadline)
                    .padding()
                    .foregroundColor(.gray)
            }

            // Add timestamp information
            Text("Built on: February 14, 2024")
                .font(.system(size: 12)) // Adjust font size and style as needed
                .padding(.top) // Add some padding above the timestamp

        }
        .padding(.top, 50) // Add padding to the top
        .onAppear {
            showWord = false
        }
    }

    func nextCard() {
        if currentIndex < flashcards.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }
}
