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
            // Copy Realm database to Documents directory if needed
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
            let config = Realm.Configuration(fileURL: destinationURL, readOnly: false, schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    // Handle migrations if needed
                    print("Migrating Realm database from version \(oldSchemaVersion)")
            })

            // Initialize Realm with the configuration
            self.realm = try Realm(configuration: config)
            print("Realm Initialized Successfully with database at: \(destinationURL)")
        } catch {
            print("Error initializing Realm: \(error.localizedDescription)")
        }
    }

    func fetchAllEmojis() -> [Emoji] {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return []
        }
        let emojis = Array(realm.objects(Emoji.self))
        print("Fetched \(emojis.count) emojis from Realm")
        return emojis
    }

    func addEmoji(_ emoji: Emoji) {
        guard let realm = realm else {
            print("Realm is not initialized.")
            return
        }
        do {
            try realm.write {
                realm.add(emoji)
            }
        } catch {
            print("Unable to add emoji: \(error.localizedDescription)")
        }
    }
}
