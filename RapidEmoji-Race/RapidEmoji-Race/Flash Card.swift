// FlashCard.swift
// RapidEmoji-Race

import RealmSwift

class Flashcard: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId  // Unique identifier for each flashcard
    @Persisted var emoji: String  // Emoji character for the flashcard
    @Persisted var word: String  // Word associated with the emoji

    // Convenience initializer to create new flashcards
    convenience init(emoji: String, word: String) {
        self.init()
        self.emoji = emoji
        self.word = word
    }
}

// Sample data can be created and added to the Realm database when the app runs for the first time or during development testing.
// The following is an example of how you might add this sample data to Realm:

import RealmSwift

class DatabaseManager {
    private var database: Realm

    init() {
        // Initialize the Realm database
        self.database = try! Realm()
    }

    // Function to add sample flashcards to the Realm database
    func addSampleFlashcards() {
        let sampleFlashcards = [
            Flashcard(emoji: "😀", word: "Smile"),
            Flashcard(emoji: "🍎", word: "Apple"),
            Flashcard(emoji: "🚗", word: "Car"),
            Flashcard(emoji: "🌲", word: "Tree"),
            Flashcard(emoji: "🐱", word: "Cat"),
            Flashcard(emoji: "📚", word: "Book"),
            Flashcard(emoji: "🚀", word: "Rocket"),
            Flashcard(emoji: "🎩", word: "Hat"),
            Flashcard(emoji: "🌂", word: "Umbrella"),
            Flashcard(emoji: "⏰", word: "Clock")
        ]

        try! database.write {
            database.add(sampleFlashcards)
        }
    }
}

// Usage:
// let databaseManager = DatabaseManager()
// databaseManager.addSampleFlashcards()

// Remember to call `addSampleFlashcards()` judiciously, as every call will add these entries to the database again.
// Typically, you might check if the database is empty before adding these sample data, or have a debug menu option to add sample data for testing.



