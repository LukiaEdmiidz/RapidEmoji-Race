// Flashcard.kt

package com.edmiidz.rapidemoji_race

import android.os.Bundle
import androidx.activity.ComponentActivity
// ... other imports ...

// Import the Flashcard class
import com.edmiidz.rapidemoji_race.Flashcard

// MainActivity code...


import java.util.UUID

data class Flashcard(val id: UUID = UUID.randomUUID(), val emoji: String, val word: String, var swipeLeftCount: Int = 0)
