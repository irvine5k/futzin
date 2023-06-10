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

struct Match {
    var players: [Player] = []
    var teams: [Team] = []
    
    init(players: [Player], numberOfTeams: Int) {
        self.players = players
        self.teams = createBalancedTeams(teamCount: numberOfTeams)
        swapPlayersToBalancePositionDifference()
    }
    
    func createBalancedTeams(teamCount: Int) -> [Team] {
        guard !players.isEmpty else {
            return []
        }
        
        let sortedPlayers = players.sorted(by: { $0.stars > $1.stars })
        var teams: [Team] = Array(repeating: Team(players: []), count: teamCount)
        
        var teamIndex = 0
        var totalStars: [Int] = Array(repeating: 0, count: teamCount)
        
        for player in sortedPlayers {
            var minTotalStarsDiff = Int.max
            var selectedTeamIndex = 0
            
            for (index, totalStarsDiff) in totalStars.enumerated() {
                if totalStarsDiff < minTotalStarsDiff {
                    minTotalStarsDiff = totalStarsDiff
                    selectedTeamIndex = index
                }
            }
            
            teams[selectedTeamIndex].players.append(player)
            totalStars[selectedTeamIndex] += player.stars
            
            teamIndex = (teamIndex + 1) % teamCount
        }
        
        return teams
    }
    
    mutating func swapPlayersToBalancePositionDifference() {
        var swapped = true
        var iteration = 0
        let maxIterations = 100
        
        while swapped && iteration < maxIterations {
            swapped = false
            
            for (teamIndex, team) in teams.enumerated() {
                let originalOffensiveCount = team.offensivePlayersCount
                let originalDefensiveCount = team.defensivePlayersCount
                let originalPositionDifference = abs(originalOffensiveCount - originalDefensiveCount)
                
                for (playerIndex, player) in team.players.enumerated() {
                    guard getPlayersWithSameStars(player: player, team: team) != nil else {
                        continue
                    }
                    
                    var bestSwapTeamIndex = -1
                    var bestSwapPlayerIndex = -1
                    var minPositionDifference = originalPositionDifference
                    
                    for (swapTeamIndex, swapTeam) in teams.enumerated() {
                        guard swapTeamIndex != teamIndex else {
                            continue
                        }
                        
                        for (swapPlayerIndex, swapPlayer) in swapTeam.players.enumerated() {
                            guard swapPlayer.stars == player.stars else {
                                continue
                            }
                            
                            let teamOffensiveCount = originalOffensiveCount - (player.position == .offensive ? 1 : 0) + (swapPlayer.position == .offensive ? 1 : 0)
                            let teamDefensiveCount = originalDefensiveCount - (player.position == .defensive ? 1 : 0) + (swapPlayer.position == .defensive ? 1 : 0)
                            
                            let positionDifference = abs(teamOffensiveCount - teamDefensiveCount)
                            
                            if positionDifference < minPositionDifference {
                                bestSwapTeamIndex = swapTeamIndex
                                bestSwapPlayerIndex = swapPlayerIndex
                                minPositionDifference = positionDifference
                            }
                        }
                    }
                    
                    if bestSwapTeamIndex != -1 && bestSwapPlayerIndex != -1 {
                        // Perform the swap
                        let swapPlayer = teams[bestSwapTeamIndex].players[bestSwapPlayerIndex]
                        teams[teamIndex].players[playerIndex] = swapPlayer
                        teams[bestSwapTeamIndex].players[bestSwapPlayerIndex] = player
                        
                        swapped = true
                    }
                }
            }
            
            iteration += 1
        }
    }

    func getPlayersWithSameStars(player: Player, team: Team) -> [Player]? {
        return team.players.filter { $0.stars == player.stars && $0.id != player.id }
    }

}


