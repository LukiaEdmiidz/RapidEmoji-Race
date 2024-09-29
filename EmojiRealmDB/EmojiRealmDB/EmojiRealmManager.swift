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
            // Attempt to find the Realm database in the app's main bundle
            guard let bundledRealmURL = Bundle.main.url(forResource: "EmojiRealmDB", withExtension: "realm") else {
                print("Failed to find 'EmojiRealmDB.realm' in app bundle.")
                return
            }

            // Define the configuration for Realm with the bundled Realm file
            let config = Realm.Configuration(fileURL: bundledRealmURL, readOnly: false, schemaVersion: 1, 
                migrationBlock: { migration, oldSchemaVersion in
                    // Handle migrations if needed
            })

            // Initialize Realm with the configuration
            self.realm = try Realm(configuration: config)
            print("Realm Initialized Successfully with bundled database at: \(bundledRealmURL)")
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }



    func fetchAllEmojis() -> [Emoji] {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized 001.")
            return []
        }
        let emojis = Array(realm.objects(Emoji.self))
        print("DebugNote: Fetched \(emojis.count) emojis")
        return emojis
    }

    func addEmoji(_ emoji: Emoji) {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized 002.")
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
            print("DebugNote: Realm is not initialized 003.")
            return nil
        }
        return realm.object(ofType: Emoji.self, forPrimaryKey: emojiString)
    }

    func updateEmoji(_ emojiString: String, newEmoji: Emoji) {
        guard let realm = realm else {
            print("DebugNote: Realm is not initialized 004.")
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
            print("DebugNote: Realm is not initialized 005.")
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
