//
//  StartScreenView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 9/29/24.
//

import SwiftUI
import AVFoundation

struct StartScreenView: View {
    // State variables
    @State private var selectedLanguage: String? = nil
    @State private var showButtons = true
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if showButtons {
                    // "Hello" Button
                    Button(action: {
                        speakText("Hello", language: "en-US")
                        selectedLanguage = "en-US"
                        showButtons = false
                    }) {
                        Text("Hello")
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // "Bonjour" Button
                    Button(action: {
                        speakText("Bonjour", language: "fr-CA")
                        selectedLanguage = "fr-CA"
                        showButtons = false
                    }) {
                        Text("Bonjour")
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // "こんにちは" Button
                    Button(action: {
                        speakText("こんにちは", language: "ja-JP")
                        selectedLanguage = "ja-JP"
                        showButtons = false
                    }) {
                        Text("こんにちは")
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                } else {
                    // Label to show selected language
                    Text("You selected: \(selectedLanguage == "en-US" ? "English" : selectedLanguage == "fr-CA" ? "French" : "Japanese")")
                        .font(.largeTitle)
                        .padding()

                    // Play Button to navigate to ContentView with the selected language
                    NavigationLink(destination: ContentView(language: selectedLanguage ?? "en-US")) {
                        Text("Play")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                    // Return Button to go back to StartScreenView
                    Button(action: {
                        selectedLanguage = nil
                        showButtons = true
                    }) {
                        Text("Return")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }

    // Function to speak the text in the chosen language
    func speakText(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }
}
