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
    
    @ObservedObject var group: GroupModel
    
    @State private var selectedPlayers: Set<PlayerModel> = []
    @State private var isButtonEnabled = false
    @State private var isCreatingPlayer = false
    @State private var isUpdatingPlayer = false
    @State private var selectedPlayer: Player!
    @State private var selectedPlayerModel: PlayerModel!
    
    var body: some View {
        List {
            ForEach(Array(group.players as? Set<PlayerModel> ?? []), id: \.self) { player in
                HStack {
                    PlayerListRow(player: player)
                    
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
                .onLongPressGesture {
                    selectedPlayerModel = player
                    selectedPlayer = Player.fromModel(player)
                    isUpdatingPlayer = true
                }
                .sheet(isPresented: $isUpdatingPlayer, content: {
                    EditPlayerView(initialPlayer: $selectedPlayer, onPlayerUpdated: updatePlayer)
                })
            }
            .onDelete { indexSet in
                deletePlayers(at: indexSet)
            }
        }
        .navigationBarItems(
            leading: Button ("Add Player") {
                isCreatingPlayer = true
            },
            trailing: NavigationLink(
                "Generate Teams",
                value: Route.match(players: Array(selectedPlayers.map(Player.fromModel)), teamCount: 4)
            )
            .disabled(!isButtonEnabled)
        )
        .onChange(of: selectedPlayers) { selectedPlayers in
            isButtonEnabled = selectedPlayers.count == 20
        }
        .navigationTitle("Player List")
        .sheet(isPresented: $isCreatingPlayer, content: {
            PlayerCreatorView(
                group: group,
                onPlayerCreated: {
                isCreatingPlayer = false
            })
        })
    }
    
    private func createMatch() -> Match {
        return Match(players: Array(selectedPlayers.map(Player.fromModel)), numberOfTeams: 4)
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
            let players = Array(group.players as? Set<PlayerModel> ?? [])
            let player = players[index]
            group.removeFromPlayers(player)
            viewContext.delete(player)
        }

        do {
            try viewContext.save()
        } catch {
            // Handle error
        }
    }
    
    private func updatePlayer(updatedPlayer: Player) {
        do {
            viewContext.delete(selectedPlayerModel)
            group.removeFromPlayers(selectedPlayerModel)
            let updatedPlayerModel = PlayerModel(context: viewContext)
            updatedPlayerModel.name = updatedPlayer.name
            updatedPlayerModel.stars = Int16(updatedPlayer.stars)
            updatedPlayerModel.position = updatedPlayer.position.rawValue
            group.addToPlayers(updatedPlayerModel)
            try viewContext.save()
            isUpdatingPlayer = false
        } catch {
            // handleError
        }
    }
}

struct PlayerListRow: View {
    
    @ObservedObject var player: PlayerModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(player.name ?? "")
                    .font(.headline)
                
                Image(systemName: player.position == PlayerPosition.offensive.rawValue ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                    .foregroundColor(player.position == PlayerPosition.offensive.rawValue ? .red : .blue)

            }
            
            StaticStarRating(rating: Int(player.stars))
        }
    }
}

