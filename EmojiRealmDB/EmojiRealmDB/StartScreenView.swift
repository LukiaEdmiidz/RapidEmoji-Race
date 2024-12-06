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
    private let appVersion = "20241205001" // Define the version number

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if showButtons {
                    // "Hello" Button for English
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

                    // "Bonjour" Button for French
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

                    // "こんにちは" Button for Japanese
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

                    // "你好" Button for Mandarin Chinese
                    Button(action: {
                        speakText("你好", language: "zh-Hant")
                        selectedLanguage = "zh-Hant"
                        showButtons = false
                    }) {
                        Text("你好")
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

                } else {
                    Text(selectedLanguageLabel())
                        .font(.largeTitle)
                        .padding()
                        .onTapGesture {
                            speakText(selectedLanguageLabel(), language: selectedLanguage ?? "en-US")
                        }

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
                    } else if selectedLanguage == "zh-Hant" {
                        Button(action: {
                            speakText("你好", language: "zh-Hant")
                        }) {
                            Text("你好")
                                .font(.largeTitle)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }

                    NavigationLink(destination: ContentView(language: selectedLanguage ?? "en-US")) {
                        Text("Play")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

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

                // Display the version number at the bottom
                Spacer()
                Text("Version: \(appVersion)")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding()
            .navigationTitle("Welcome")
        }
    }

    func speakText(_ text: String, language: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.rate = 0.5
        synthesizer.speak(utterance)
    }

    func selectedLanguageLabel() -> String {
        switch selectedLanguage {
        case "en-US":
            return "You selected: English"
        case "fr-CA":
            return "Vous avez sélectionné : Français"
        case "ja-JP":
            return "あなたが選んだのは: 日本語"
        case "zh-Hant":
            return "你選擇了: 中文"
        default:
            return "You selected: English"
        }
    }
}
