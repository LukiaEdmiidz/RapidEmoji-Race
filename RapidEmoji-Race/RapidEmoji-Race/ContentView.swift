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
                            if self.offset.width > 100 {  // swiped right
                                self.showWord = false
                                self.nextCard()
                            } else if self.offset.width < -100 {  // swiped left
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
//                Text(flashcards[currentIndex].word)
//                    .font(.title)
//                    .padding()
            } else {
                Text("Tap to reveal word!")
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
    
    func nextCard() {
        if currentIndex < flashcards.count - 1 {
            currentIndex += 1
        } else {
            currentIndex = 0
        }
    }



}



