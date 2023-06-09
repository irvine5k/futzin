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

struct Team {
    var players: [Player]
}

struct Match {
    var players: [Player] = []
    var teams: [Team] = []
    
    init(players: [Player], numberOfTeams: Int) {
        self.players = players
        self.teams = createBalancedTeams(players: players, numberOfTeams: numberOfTeams)
    }
    
    func createBalancedTeams(players: [Player], numberOfTeams: Int) -> [Team] {
        var teams = [Team]()
        let sortedPlayers = players.sorted(by: { $0.stars > $1.stars })
        
        for _ in 0..<numberOfTeams {
            teams.append(Team(players: []))
        }
        
        for (index, player) in sortedPlayers.enumerated() {
            let teamIndex = index % numberOfTeams
            teams[teamIndex].players.append(player)
        }
        
        return teams
    }
}


