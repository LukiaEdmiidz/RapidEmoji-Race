import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var showWord: Bool = false
    @State private var currentIndex: Int = 0
    @State private var offset: CGSize = .zero
    @State private var flashcards: [Flashcard] = []
    @State private var showRecycleIcon = false
    @State private var showDeleteIcon = false

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
                        .offset(offset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset = gesture.translation

                                    // Handle swipe up behavior
                                    if self.offset.height < -100 {
                                        if flashcards[currentIndex].knownCount == 0 {
                                            showRecycleIcon = true
                                        } else if flashcards[currentIndex].knownCount == 1 {
                                            showDeleteIcon = true
                                        }
                                    }
                                }
                                .onEnded { _ in
                                    if self.offset.height < -150 { // Sufficient swipe up gesture
                                        if flashcards[currentIndex].knownCount == 0 {
                                            // Increment Known_Count and move to next card
                                            incrementKnownCount(for: flashcards[currentIndex])
                                            showRecycleIcon = false
                                            nextCard()
                                        } else if flashcards[currentIndex].knownCount == 1 {
                                            // Delete the card and move to next card
                                            deleteCard(flashcard: flashcards[currentIndex])
                                            showDeleteIcon = false
                                            nextCard()
                                        }
                                    } else if self.offset.width > 100 { // Swiped right -> next card
                                        showWord = false
                                        nextCard()
                                    } else if self.offset.width < -100 { // Swiped left -> previous card
                                        showWord = false
                                        previousCard()
                                    }
                                    self.offset = .zero
                                    self.showRecycleIcon = false
                                    self.showDeleteIcon = false
                                }
                        )
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                withAnimation {
                                    self.showWord.toggle()
                                }
                                // Speak the word if it's being shown
                                if self.showWord {
                                    speakText(flashcards[currentIndex].emoji, language: language)
                                }
                            }
                        )

                    // Show the recycle or delete icon based on Known_Count
                    if showRecycleIcon {
                        Text("♻️")
                            .font(.largeTitle)
                            .offset(x: 0, y: -150)
                            .transition(.scale)
                    } else if showDeleteIcon {
                        Text("🗑️")
                            .font(.largeTitle)
                            .offset(x: 0, y: -150)
                            .transition(.scale)
                    }
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
            currentIndex = (currentIndex + 1) % flashcards.count
        }
    }

    // Function to go to the previous card
    func previousCard() {
        if !flashcards.isEmpty {
            if currentIndex > 0 {
                currentIndex -= 1
            } else {
                currentIndex = flashcards.count - 1  // Loop to the last card
            }
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
        DispatchQueue.main.async {
            self.flashcards = emojis.map { Flashcard(emoji: $0.Emoji, english: $0.English, knownCount: $0.Known_Count) }
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
