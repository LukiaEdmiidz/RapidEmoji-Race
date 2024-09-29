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
                    // Display the selected language in its language and make it tappable to speak
                    Text(selectedLanguageLabel())
                        .font(.largeTitle)
                        .padding()
                        .onTapGesture {
                            speakText(selectedLanguageLabel(), language: selectedLanguage ?? "en-US")
                        }

                    // Show the "Hello", "Bonjour", or "こんにちは" button based on the selected language
                    if selectedLanguage == "en-US" {
                        Button(action: {
                            speakText("Hello", language: "en-US")
                        }) {
                            Text("Hello")
                                .font(.largeTitle)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else if selectedLanguage == "fr-CA" {
                        Button(action: {
                            speakText("Bonjour", language: "fr-CA")
                        }) {
                            Text("Bonjour")
                                .font(.largeTitle)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else if selectedLanguage == "ja-JP" {
                        Button(action: {
                            speakText("こんにちは", language: "ja-JP")
                        }) {
                            Text("こんにちは")
                                .font(.largeTitle)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

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

    // Function to return the selected language label in its respective language
    func selectedLanguageLabel() -> String {
        switch selectedLanguage {
        case "en-US":
            return "You selected: English"
        case "fr-CA":
            return "Vous avez sélectionné : Français" // French version of "You selected: French"
        case "ja-JP":
            return "あなたが選んだのは: 日本語" // Japanese version of "You selected: Japanese"
        default:
            return "You selected: English"
        }
    }
}
