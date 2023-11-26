package com.edmiidz.rapidemoji_race

import java.util.*

// Assuming Flashcard data class is defined here or in another file that's imported
data class Flashcard(val id: UUID = UUID.randomUUID(), val emoji: String, val word: String, var swipeLeftCount: Int = 0)

fun handleSwipeLeft(flashcards: MutableList<Flashcard>, currentIndex: Int) {
    val flashcard = flashcards[currentIndex]
    flashcard.swipeLeftCount++
    if (flashcard.swipeLeftCount >= 2) {
        flashcards.removeAt(currentIndex)
    } else {
        repositionFlashcardInQueue(flashcards, currentIndex, 20)
    }
}

fun handleSwipeRight(flashcards: MutableList<Flashcard>, currentIndex: Int) {
    repositionFlashcardInQueue(flashcards, currentIndex, 20)
}

fun repositionFlashcardInQueue(flashcards: MutableList<Flashcard>, currentIndex: Int, positions: Int) {
    val flashcard = flashcards.removeAt(currentIndex)
    val newPosition = (currentIndex + positions).coerceAtMost(flashcards.size)
    flashcards.add(newPosition, flashcard)
}
