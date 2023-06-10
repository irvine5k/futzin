//
//  Match.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI

struct MatchView: View {
    var match: Match

    var body: some View {
        List {
            ForEach(match.teams.indices, id: \.self) { index in
                let team = match.teams[index]
                VStack(alignment: .leading) {
                    Text("Team \(index + 1)")
                        .font(.headline)
                        .padding(.bottom, 4)
                    ForEach(team.players) { player in
                        Text("\(player.name)")
                    }
                }
            }
        }
        .navigationBarTitle("Teams")
        .toolbar {
            ShareLink(item: match.toFormattedText())
        }
    }
}

struct MatchView_Preview: PreviewProvider {
    static var players: [Player] = [
        Player(stars: 5, name: "teste 1", position: .offensive),
        Player(stars: 4, name: "teste 2", position: .offensive),
        Player(stars: 3, name: "teste 3", position: .offensive),
        Player(stars: 2, name: "teste 4", position: .offensive),
        Player(stars: 1, name: "teste 5", position: .offensive),
        Player(stars: 5, name: "teste 6", position: .offensive),
        Player(stars: 4, name: "teste 7", position: .offensive),
        Player(stars: 3, name: "teste 8", position: .offensive),
        Player(stars: 2, name: "teste 9", position: .offensive),
        Player(stars: 1, name: "teste 10", position: .offensive),
        
    ]
    static var previews: some View {
        MatchView(match: Match(players: players, numberOfTeams: 2))
    }
}
