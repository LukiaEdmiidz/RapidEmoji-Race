//
//  EmojiRealmManager.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import RealmSwift
import Foundation

class EmojiRealmManager {
    private var realm: Realm?

    init() {
        do {
            // Realm initialization code
            let fileManager = FileManager.default
            let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationURL = documentsURL.appendingPathComponent("EmojiRealmDB.realm")

            // Check if the file already exists in the Documents directory
            if !fileManager.fileExists(atPath: destinationURL.path) {
                guard let bundledRealmURL = Bundle.main.url(forResource: "EmojiRealmDB", withExtension: "realm") else {
                    print("Failed to find 'EmojiRealmDB.realm' in app bundle.")
                    return
                }
                // Copy the bundled Realm file to the Documents directory
                do {
                    try fileManager.copyItem(at: bundledRealmURL, to: destinationURL)
                    print("Copied Realm file from bundle to Documents directory")
                } catch {
                    print("Error copying Realm file: \(error.localizedDescription)")
                    return
                }
            }

            // Define the configuration for Realm with the copied file in the Documents directory
            let config = Realm.Configuration(
                fileURL: destinationURL,
                schemaVersion: 6,  // Increment this schema version if it was previously 5
                migrationBlock: { migration, oldSchemaVersion in
                    if oldSchemaVersion < 6 {
                        // Apply any necessary migrations
                        migration.enumerateObjects(ofType: Emoji.className()) { oldObject, newObject in
                            newObject?["Viewed"] = 0 // Set default value for Viewed
                        }
                    }
                }
            )


            // Initialize Realm with the configuration
            self.realm = try Realm(configuration: config)
            print("Realm Initialized Successfully with database at: \(destinationURL)")
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }

    // Fetch emojis filtered by Known_Count <= 2 and ordered by frequency in descending order
    func fetchFilteredEmojis() -> [Emoji] {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return []
        }

        let emojis = realm.objects(Emoji.self)
            .filter("Known_Count <= 2")  // Filter to only include emojis where Known_Count is 2 or less
            .sorted(byKeyPath: "frequency", ascending: true)  // Sort by frequency in descending order
            .prefix(20)  // Only load the first 20 records

        print("Fetched \(emojis.count) filtered emojis from Realm")
        return Array(emojis)
    }

    // Increment Known_Count by 1 for a specific emoji
    func incrementKnownCount(for emojiString: String) {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return
        }

        if let emojiToUpdate = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) {
            do {
                try realm.write {
                    emojiToUpdate.Known_Count += 1
                }
                print("Incremented Known_Count for \(emojiString)")
            } catch {
                print("Unable to increment Known_Count: \(error.localizedDescription)")
            }
        } else {
            print("Emoji not found for incrementing Known_Count.")
        }
    }

    // Delete a specific emoji
    func deleteEmoji(_ emojiString: String) {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return
        }

        if let emojiToDelete = realm.object(ofType: Emoji.self, forPrimaryKey: emojiString) {
            do {
                try realm.write {
                    realm.delete(emojiToDelete)
                }
                print("Deleted \(emojiString) from Realm")
            } catch {
                print("Unable to delete emoji: \(error.localizedDescription)")
            }
        } else {
            print("Emoji not found for deletion.")
        }
    }
}
