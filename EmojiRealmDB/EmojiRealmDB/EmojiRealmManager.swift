//
//  EmojiRealmManager.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import Foundation
import RealmSwift

class EmojiRealmManager {
    private var realm: Realm

    init() {
        // Construct the file URL for the bundled Realm database
        let fileURL = Bundle.main.url(forResource: "EmojiRealmDB", withExtension: "realm")

        // Create a configuration that uses the bundled Realm file
        let config = Realm.Configuration(fileURL: fileURL,
                                         readOnly: false, // Set to `true` if the Realm should be read-only
                                         schemaVersion: 1) // Use an appropriate schema version

        // Initialize the Realm with the configuration
        self.realm = try! Realm(configuration: config)
    }

    func fetchAllEmojis() -> [Emoji] {
        let emojis = Array(self.realm.objects(Emoji.self))  // Use the custom-configured Realm instance
        print("DebugNote: Fetched \(emojis.count) emojis")
        return emojis
    }
    
    // MARK: - Create
    func addEmoji(_ emoji: Emoji) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(emoji)
            }
        } catch {
            print("DebugNote: Unable to add emoji: \(error.localizedDescription)")
        }
    }
    
    func fetchEmoji(by emojiString: String) -> Emoji? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Emoji.self, forPrimaryKey: emojiString)
        } catch {
            print("DebugNote: Unable to fetch emoji: \(error.localizedDescription)")
            return nil
        }
    }

    // MARK: - Update
    func updateEmoji(_ emojiString: String, newEmoji: Emoji) {
        do {
            let realm = try Realm()
            if let emojiToUpdate = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) {
                try realm.write {
                    emojiToUpdate.English = newEmoji.English
                    emojiToUpdate.French = newEmoji.French
                    emojiToUpdate.Spanish = newEmoji.Spanish
                    emojiToUpdate.Japanese = newEmoji.Japanese
                    emojiToUpdate.Not_Known_Count = newEmoji.Not_Known_Count
                    emojiToUpdate.Known_Count = newEmoji.Known_Count
                }
            }
        } catch {
            print("DebugNote: Unable to update emoji: \(error.localizedDescription)")
        }
    }

    // MARK: - Delete
    func deleteEmoji(_ emojiString: String) {
        do {
            let realm = try Realm()
            if let emojiToDelete = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) {
                try realm.write {
                    realm.delete(emojiToDelete)
                }
            }
        } catch {
            print("DebugNote: Unable to delete emoji: \(error.localizedDescription)")
        }
    }
}
