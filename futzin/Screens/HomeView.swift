//
//  Home.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isCreatingPlayer = false
    @State private var presentedRoutes: [Route] = []
    
    var body: some View {
        NavigationStack(path: $presentedRoutes) {
            VStack {
                PlayerListView()
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .match(let players, let teamCount):
                    let match = Match(players: players, numberOfTeams: teamCount)
                    MatchView(match: match)
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

