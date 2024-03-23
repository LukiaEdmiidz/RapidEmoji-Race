//
//  Item.swift
//  RapidEmoji-Race
//
//  Created by Lukia Edmiidz on 11/1/23.
//

import Foundation
import SwiftData
import RealmSwift


@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
