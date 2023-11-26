package com.edmiidz.rapidemoji_race

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
import com.edmiidz.rapidemoji_race.ui.theme.RapidEmojiRaceTheme
import java.util.UUID
import androidx.compose.runtime.*
import androidx.compose.foundation.layout.*
import androidx.compose.material3.*
import androidx.compose.ui.*
import androidx.compose.ui.unit.*
import androidx.compose.foundation.clickable
import androidx.compose.foundation.layout.Column



//Flashcard Data Class
data class Flashcard(val id: UUID = UUID.randomUUID(), val emoji: String, val word: String)

// List of Flashcards
val flashcards = listOf(
    Flashcard(emoji = "👋", word = "Hello"),
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




class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        setContent {
            RapidEmojiRaceTheme {
                // A surface container using the 'background' color from the theme
                Surface(
                    modifier = Modifier.fillMaxSize(),
                    color = MaterialTheme.colorScheme.background
                ) {
                    FlashcardScreen() // Use FlashcardScreen here
                }
            }
        }
    }
}

@Composable
fun FlashcardScreen() {
    var showWord by remember { mutableStateOf(false) }
    var currentIndex by remember { mutableStateOf(0) }

    Column(modifier = Modifier.padding(16.dp)) {
        FlashcardView(
            flashcard = flashcards[currentIndex],
            showWord = showWord,
            onCardTap = { showWord = !showWord }
        )
    }

    Row(horizontalArrangement = Arrangement.SpaceEvenly) {
        Button(onClick = { 
            if (currentIndex > 0) currentIndex-- 
            showWord = false  // Reset word visibility
        }) {
            Text("Previous")
        }

        Button(onClick = { 
            if (currentIndex < flashcards.size - 1) currentIndex++ 
            showWord = false  // Reset word visibility
        }) {
            Text("Next")
        }
    }
}


@Composable
fun FlashcardView(flashcard: Flashcard, showWord: Boolean, onCardTap: () -> Unit) {
    Column(
        modifier = Modifier
            .padding(16.dp)
            .fillMaxWidth()  // Fills the maximum width of the parent
            .clickable(onClick = onCardTap),  // Calls the onCardTap function when clicked
        horizontalAlignment = Alignment.CenterHorizontally,  // Centers content horizontally
        verticalArrangement = Arrangement.Center  // Centers content vertically
    ) {
        Text(
            text = flashcard.emoji,
            fontSize = 200.sp,  // Adjust the size as desired
            modifier = Modifier.padding(16.dp)
        )
        if (showWord) {
            Text(
                text = flashcard.word,
                fontSize = 24.sp,  // Adjust the title font size as desired
                modifier = Modifier.padding(16.dp)
            )
        }
    }
}


@Preview(showBackground = true)
@Composable
fun FlashcardScreenPreview() {
    RapidEmojiRaceTheme {
        FlashcardScreen()
    }
}
