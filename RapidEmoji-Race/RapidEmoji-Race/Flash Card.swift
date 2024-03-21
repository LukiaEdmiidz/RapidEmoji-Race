//
//  Flash Card.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI

struct Flashcard: Identifiable {
    var id = UUID()
    var emoji: String
    var word: String
}


let flashcards: [Flashcard] = [
    Flashcard(emoji: "😀", word: "Smile"),
    Flashcard(emoji: "🍎", word: "Red Apple"),
    Flashcard(emoji: "🚗", word: "Car"),
    Flashcard(emoji: "🌲", word: "Tree"),
    Flashcard(emoji: "🐱", word: "Cat"),
    Flashcard(emoji: "📚", word: "Book"),
    Flashcard(emoji: "🚀", word: "Rocket"),
    Flashcard(emoji: "🎩", word: "Hat"),
    Flashcard(emoji: "🌂", word: "Umbrella"),
    Flashcard(emoji: "⏰", word: "Clock")
]


