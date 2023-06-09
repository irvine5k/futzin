//
//  PlayerList.swift
//  futzin
//
//  Created by Kelven Galvao on 09/06/23.
//

import SwiftUI
import CoreData

struct PlayerListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \PlayerModel.name, ascending: true)],
        animation: .default)
    private var players: FetchedResults<PlayerModel>
    
    var body: some View {
        List(players, id: \.self) { player in
            VStack(alignment: .leading) {
                Text(player.name ?? "")
                    .font(.headline)
                Text("Stars: \(player.stars)")
                    .font(.subheadline)
                Text("Position: \(player.position ?? "")")
                    .font(.subheadline)
            }
        }
        .navigationTitle("Player List")
    }
}

