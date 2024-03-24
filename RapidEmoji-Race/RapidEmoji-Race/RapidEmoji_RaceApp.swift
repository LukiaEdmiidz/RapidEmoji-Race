//
//  RapidEmoji_RaceApp.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import SwiftUI
import RealmSwift

@main
struct EmojiRaceMainApp: App {
    init() {
        // Initialize and potentially populate your Realm database here
        initializeRealm()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func initializeRealm() {
        do {
            let realm = try Realm()
            // Check if the realm is empty and if so, populate it with initial data
            if realm.objects(Flashcard.self).isEmpty {
                try realm.write {
                    // Populate the realm with initial data
                    // Example: realm.add(Flashcard(emoji: "😀", word: "Smile"))
                }
            }
        } catch {
            fatalError("Failed to initialize Realm: \(error)")
        }
    }
}



