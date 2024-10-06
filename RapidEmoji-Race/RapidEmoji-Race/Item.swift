//
//  Item.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//




import Foundation
import RealmSwift

class Item: Object {
    @Persisted var timestamp: Date = Date()

    convenience init(timestamp: Date) {
        self.init()
        self.timestamp = timestamp
    }
}



