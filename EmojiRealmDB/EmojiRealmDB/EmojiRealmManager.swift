//
//  EmojiRealmManager.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 3/23/24.
//

import Foundation
import RealmSwift

class EmojiRealmDB {

    // MARK: - Create
    func addEmoji(_ emoji: Emoji) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(emoji)
            }
        } catch {
            print("Unable to add emoji: \(error.localizedDescription)")
        }
    }

    // MARK: - Read
    func fetchAllEmojis() -> Results<Emoji> {
        do {
            let realm = try Realm()
            return realm.objects(Emoji.self)
        } catch {
            print("Unable to fetch emojis: \(error.localizedDescription)")
            return Results<Emoji>()
        }
    }
    
    func fetchEmoji(by emojiString: String) -> Emoji? {
        do {
            let realm = try Realm()
            return realm.object(ofType: Emoji.self, forPrimaryKey: emojiString)
        } catch {
            print("Unable to fetch emoji: \(error.localizedDescription)")
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
            print("Unable to update emoji: \(error.localizedDescription)")
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
            print("Unable to delete emoji: \(error.localizedDescription)")
        }
    }
}
