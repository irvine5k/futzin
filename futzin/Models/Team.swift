//
//  Team.swift
//  futzin
//
//  Created by Kelven Galvao on 10/06/23.
//

import Foundation

struct Team: Identifiable, Hashable, Equatable {
    
    static func == (lhs: Team, rhs: Team) -> Bool {
            return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
    }
    
    let id = UUID()
    var players: [Player]
    
    var overallStars: Int {
        return players.reduce(0) { $0 + $1.stars }
    }
    
    var defensivePlayersCount: Int {
        return players.filter { $0.position == .defensive }.count
    }

    var offensivePlayersCount: Int {
        return players.filter { $0.position == .offensive }.count
    }
}
