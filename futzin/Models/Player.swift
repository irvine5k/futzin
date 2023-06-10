//
//  Player.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import Foundation
import CoreData

enum PlayerPosition: String, CaseIterable {
    case defensive
    case offensive
}

struct Player: Identifiable {
    let id = UUID()
    var stars: Int
    var name: String
    var position: PlayerPosition
}
