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
                    Text("Team \(index + 1) - Overall \(team.overallStars)")
                        .font(.headline)
                        .padding(.bottom, 4)
                    Text("Offensive Players \(team.offensivePlayersCount)")
                        .font(.body)
                        .padding(.bottom, 4)
                    Text("Defensive Players \(team.defensivePlayersCount)")
                        .font(.body)
                        .padding(.bottom, 4)
                    ForEach(team.players) { player in
                        Text("\(player.name) - Stars: \(player.stars)")
                    }
                }
            }
        }.onAppear {
            print(match.teams)
        }
        .navigationBarTitle("Teams")
    }
}
