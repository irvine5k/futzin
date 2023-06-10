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
    
    @State private var selectedPlayers: Set<PlayerModel> = []
    @State private var isButtonEnabled = false
    @State private var isNavigationActive = false
    @State private var isUpdatingPlayer = false
    
    var body: some View {
        List {
            ForEach(players, id: \.self) { player in
                HStack {
                    VStack(alignment: .leading) {
                        Text(player.name ?? "")
                            .font(.headline)
                        Text("Stars: \(player.stars)")
                            .font(.subheadline)
                        Text("Position: \(player.position ?? "")")
                            .font(.subheadline)
                    }
                    
                    Spacer()
                    
                    if selectedPlayers.contains(player) {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    toggleSelection(for: player)
                }
            }
            .onDelete { indexSet in
                deletePlayers(at: indexSet)
            }
        }
        .navigationBarItems(trailing: NavigationLink(
            destination: MatchView(match: createMatch()),
            isActive: $isNavigationActive,
            label: {
                Button("Submit") {
                    isNavigationActive = true
                }
                .disabled(!isButtonEnabled)
            }
        )
        .disabled(!isButtonEnabled))
        .onChange(of: selectedPlayers) { selectedPlayers in
            isButtonEnabled = selectedPlayers.count == 20
        }
        .navigationTitle("Player List")
    }
    
    private func createMatch() -> Match {
        return Match(players: Array(selectedPlayers.map(mapToPlayer)), numberOfTeams: 4)
    }
    
    private func toggleSelection(for player: PlayerModel) {
        if selectedPlayers.contains(player) {
            selectedPlayers.remove(player)
        } else {
            selectedPlayers.insert(player)
        }
    }
    
    private func deletePlayers(at offsets: IndexSet) {
        for index in offsets {
            let player = players[index]
            viewContext.delete(player)
        }

        do {
            try viewContext.save()
        } catch {
            // Handle error
        }
    }
    
    private func mapToPlayer(playerModel: PlayerModel) -> Player {
        let position = PlayerPosition(rawValue: playerModel.position ?? "") ?? .defensive

        return Player(
            stars: Int(playerModel.stars),
            name: playerModel.name ?? "Joe Doe",
            position: position
        )
    }
}

