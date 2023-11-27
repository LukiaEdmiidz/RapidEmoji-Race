// FlashcardUtils.kt

package com.edmiidz.rapidemoji_race

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.clickable
import androidx.compose.foundation.gestures.Orientation
import androidx.compose.foundation.gestures.draggable
import androidx.compose.foundation.gestures.rememberDraggableState
import androidx.compose.foundation.layout.*
import androidx.compose.material3.Button
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.IntOffset
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.edmiidz.rapidemoji_race.ui.theme.RapidEmojiRaceTheme
import java.util.*
import kotlin.math.roundToInt
import com.edmiidz.rapidemoji_race.Flashcard


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
