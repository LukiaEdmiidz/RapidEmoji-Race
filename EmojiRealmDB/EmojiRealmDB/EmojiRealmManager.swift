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
            // Copy Realm database to Documents directory if needed (existing logic)
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

    // Fetch emojis filtered by Known_Count <= 2 and ordered by frequency in descending order
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

}
