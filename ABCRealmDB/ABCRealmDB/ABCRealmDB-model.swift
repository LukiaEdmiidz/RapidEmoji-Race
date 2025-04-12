import Foundation
import RealmSwift

class Emoji: Object {
    @objc dynamic var Emoji: String = ""
    @objc dynamic var Not_Known_Count: Int = 0
    @objc dynamic var Known_Count: Int = 0
    @objc dynamic var English: String = ""
    @objc dynamic var French: String? = nil
    @objc dynamic var Spanish: String? = nil
    @objc dynamic var Japanese: String? = nil
    @objc dynamic var frequency: Int = 0
    @objc dynamic var Viewed: Int = 0 // Add Viewed property

    override static func primaryKey() -> String? {
        return "Emoji"
    }
}

