//
//  EmojiRealmManager.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import Foundation
import RealmSwift

class EmojiRealmManager {
    private var realm: Realm?

        init() {
            do {
                // Check if the Realm file exists in the app's Documents directory
                let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let realmFileURL = documentDirectory.appendingPathComponent("EmojiRealmDB.realm")

                if !FileManager.default.fileExists(atPath: realmFileURL.path) {
                    // If the Realm file doesn't exist in Documents, copy it from the bundle
                    if let bundledRealmURL = Bundle.main.url(forResource: "EmojiRealmDB", withExtension: "realm") {
                        try FileManager.default.copyItem(at: bundledRealmURL, to: realmFileURL)
                        print("Copied Realm database to Documents directory.")
                    }
                }

                // Use the Realm file from the Documents directory
                let config = Realm.Configuration(fileURL: realmFileURL, readOnly: false, schemaVersion: 1)
                self.realm = try Realm(configuration: config)
                print("Realm Initialized Successfully at \(realmFileURL).")
            } catch {
                print("Error initializing or copying Realm: \(error)")
                self.realm = nil
            }
        }



    func fetchAllEmojis() -> [Emoji] {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized.")
            return []
        }
        let emojis = Array(realm.objects(Emoji.self))
        print("DebugNote: Fetched \(emojis.count) emojis")
        return emojis
    }

    func addEmoji(_ emoji: Emoji) {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized.")
            return
        }
        do {
            try realm.write {
                realm.add(emoji)
            }
        } catch {
            print("DebugNote: Unable to add emoji: \(error.localizedDescription)")
        }
    }

    func fetchEmoji(by emojiString: String) -> Emoji? {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized.")
            return nil
        }
        return realm.object(ofType: Emoji.self, forPrimaryKey: emojiString)
    }

    func updateEmoji(_ emojiString: String, newEmoji: Emoji) {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized.")
            return
        }
        guard let emojiToUpdate = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) else {
            print("DebugNote: Emoji to update not found.")
            return
        }
        do {
            try realm.write {
                emojiToUpdate.English = newEmoji.English
                // Update other properties as needed
                    emojiToUpdate.Not_Known_Count = newEmoji.Not_Known_Count
                    emojiToUpdate.Known_Count = newEmoji.Known_Count
            }
        } catch {
            print("DebugNote: Unable to update emoji: \(error.localizedDescription)")
        }
    }

    func deleteEmoji(_ emojiString: String) {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized.")
            return
        }
        guard let emojiToDelete = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) else {
            print("DebugNote: Emoji to delete not found.")
            return
        }
        do {
            try realm.write {
                realm.delete(emojiToDelete)
            }
        } catch {
            print("DebugNote: Unable to delete emoji: \(error.localizedDescription)")
        }
    }
}
