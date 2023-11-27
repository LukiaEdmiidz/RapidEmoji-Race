//MainActivity.kt

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
import kotlin.math.roundToInt
import com.edmiidz.rapidemoji_race.Flashcard

// Make sure to import the functions from FlashcardUtils.kt
// import com.edmiidz.rapidemoji_race.handleSwipeLeft
// import com.edmiidz.rapidemoji_race.handleSwipeRight

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            RapidEmojiRaceTheme {
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    FlashcardScreen()
                }
            }
        }
    }
}


@Composable
fun FlashcardScreen() {
    var currentIndex by remember { mutableStateOf(0) }
    var showWord by remember { mutableStateOf(false) }
    val flashcards = remember {
        mutableStateListOf(
    Flashcard(emoji = "😀", word = "Smile"),
    Flashcard(emoji = "🍎", word = "Apple"),
    Flashcard(emoji = "🚗", word = "Car"),
    Flashcard(emoji = "🌲", word = "Tree"),
    Flashcard(emoji = "🐱", word = "Cat"),
    Flashcard(emoji = "📚", word = "Book"),
    Flashcard(emoji = "🚀", word = "Rocket"),
    Flashcard(emoji = "🎩", word = "Hat"),
    Flashcard(emoji = "🌂", word = "Umbrella"),
    Flashcard(emoji = "⏰", word = "Clock")

        )
    }
    val maxIndex = flashcards.size - 1

    // Function to safely update currentIndex
    fun updateIndex(newIndex: Int) {
        currentIndex = newIndex.coerceIn(0, flashcards.size - 1)
    }

    Column(modifier = Modifier.padding(16.dp)) {
        if (flashcards.isNotEmpty()) {
            FlashcardView(
                flashcard = flashcards[currentIndex],
                showWord = showWord,
                onCardTap = { showWord = !showWord },
                onSwipeLeft = { 
                    handleSwipeLeft(flashcards, currentIndex)
                    updateIndex(currentIndex + 1)
                },
                onSwipeRight = {
                    handleSwipeRight(flashcards, currentIndex)
                    updateIndex(currentIndex - 1)
                }
            )
        }

        Row(horizontalArrangement = Arrangement.SpaceEvenly) {
            Button(onClick = { 
                if (currentIndex > 0) currentIndex-- 
                showWord = false 
            }) {
                Text("Previous")
            }
            Button(onClick = { 
                if (currentIndex < maxIndex) currentIndex++ 
                showWord = false 
            }) {
                Text("Next")
            }
        }
    }
}

@Composable
fun FlashcardView(
    flashcard: Flashcard, 
    showWord: Boolean, 
    onCardTap: () -> Unit,
    onSwipeLeft: () -> Unit, 
    onSwipeRight: () -> Unit
) {
    val dragOffset = remember { mutableStateOf(0f) }

    Column(
        modifier = Modifier
            .padding(16.dp)
            .fillMaxWidth()
            .clickable(onClick = onCardTap)
            .offset { IntOffset(dragOffset.value.roundToInt(), 0) }
            .draggable(
                orientation = Orientation.Horizontal,
                state = rememberDraggableState { delta ->
                    dragOffset.value += delta
                },
                onDragStopped = {
                    when {
                        dragOffset.value > 100 -> onSwipeRight()
                        dragOffset.value < -100 -> onSwipeLeft()
                    }
                    dragOffset.value = 0f
                }
            ),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(text = flashcard.emoji, fontSize = 200.sp)
        if (showWord) {
            Text(text = flashcard.word, fontSize = 24.sp)
        }
    }
}
