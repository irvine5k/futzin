//
//  Match.swift
//  futzin
//
//  Created by Kelven Galvao on 10/06/23.
//

import Foundation

struct Match {
    var players: [Player] = []
    var teams: [Team] = []
    
    init(players: [Player], numberOfTeams: Int) {
        self.players = players
        self.teams  = createBalancedTeams(teamCount: numberOfTeams)
    }
    
    func toFormattedText() -> String {
        var text : String = ""
        
        for index in teams.indices {
            let team: Team = teams[index]
            
            if(index > 0) {
                text = text.appending("\n")
                
            }
            text = text.appending("*Team \(index + 1)*\n")
            
            team.players.forEach { player in
                text = text.appending("\(player.name)\n")
            }
        }
        
        return text
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
}
